#! /bin/bash
# 用于安装zsh以及配置zsh
# 更新日期：2024-1-10

# ANSI 颜色代码
green="\033[32m"
red="\033[31m"
yellow="\033[33m"
font="\033[0m"
bold="\033[1m"
error_style="\033[37;41m"
ok_style="\033[37;42m"

# XDG 目录规范
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"
XDG_DATA_DIRS="/usr/local/share"
XDG_CONFIG_DIRS="/etc/xdg"

# 简单的输出
function print_ok() {
    ok="${ok_style}${bold}[OK]${font}"
    echo -e "${ok}"
    echo -e "${green}${bold}$1${font}\n"
    sleep 8
}

function print_error() {
    # 重定向错误信息到日志文件 
    exec 2>> /tmp/error.txt
    # 记录当前函数名
    echo "From function: ${FUNCNAME[1]}" >> /tmp/nginx_error.txt
    # 样式
    error="${error_style}${bold}[ERROR]${font}"
    echo -e "${error}"
    echo -e "${red}${bold}$1${font}\n"
    # 恢复标准错误 
    exec 2>&1
    sleep 5
}

function print_echo() {
    echo -e "${yellow}${bold}$1${font}\n"
    sleep 3
}

# 更新系统/包
function update_system() {
    print_echo "准备更新系统/包..."
    if (sudo apt update && sudo apt upgrade -y); then
        print_ok "系统&包更新成功"
    else    
        print_error "系统&包更新失败"
    fi
}

function install_packages() {
    print_echo "正在安装以下软件包\n
        zsh zsh\n
        curl curl\n
        wget wget\n
        git git\n
        unzip unzip解压缩\n
        fonts-firacode fira编程字体\n
        "

    if (sudo apt install -y \
        curl \
        wget \
        git \
        zsh \
        unzip \
        fonts-firacode \
        ); then
        print_ok "软件包 安装成功"
    else
        print_error "软件包 安装失败"
    fi
}

function install_ohmyzsh() {
    print_echo "正在安装ohmyzsh..."

    # 设置XDG目录规范
    local zsh_xdg_dir="$XDG_CONFIG_HOME/zsh"
    export XDG_DATA_HOME="$HOME/.local/share"
    export ZSH="$XDG_DATA_HOME/oh-my-zsh"
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

    if [ ! -d "$zsh_xdg_dir" ]; then
        mkdir -p "$zsh_xdg_dir"
    fi

    if (yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"); then
        print_ok "ohmyzsh 安装成功 \n 路径=$XDG_DATA_HOME/oh-my-zsh"
    else
        print_error "ohmyzsh 安装失败"
    fi

    print_echo "正在将zsh设置为默认shell..."
    if (chsh -s $(which zsh)); then
        print_ok "设置zsh为默认shell 成功"
    else
        print_error "设置zsh为默认shell 失败"
    fi
}


function re_zshrc() {
    print_echo "正在重写 .zshrc 配置文件..."
    # XDG目录规范
    local zsh_config_dir="$XDG_CONFIG_HOME/zsh"
    local zshrc_config_file="$XDG_CONFIG_HOME/zsh/.zshrc"
    local zshrc_config_file_url="https://raw.githubusercontent.com/1trapbox/1box/main/configs/zsh/.zshrc"
    local zshrc_alias_file="$XDG_CONFIG_HOME/zsh/alias.zsh"
    local zshrc_alias_file_url="https://raw.githubusercontent.com/1trapbox/1box/main/configs/zsh/alias.zsh"

    # 目录不存在则创建
    if [ ! -d "$zsh_config_dir" ]; then
        mkdir -p "$zsh_config_dir"
    fi

    if (curl -sl "$zshrc_config_file_url" -o "$zshrc_config_file"); then
        print_ok ".zshrc 配置文件下载成功 \n 路径=$zshrc_config_file"
        else
        print_error ".zshrc 配置文件下载失败"
    fi

    if (curl -sl "$zshrc_alias_file_url" -o "$zshrc_alias_file"); then
        print_ok "alias.zsh 配置文件下载成功 \n 路径=$zshrc_alias_file"
        else
        print_error "alias.zsh 配置文件下载失败"
    fi
}

function install_zinit() {
    if (zsh -c "source $XDG_CONFIG_HOME/zsh/.zshrc"); then
    print_echo "zinit安装成功"
    else
    print_error "zinit安装失败"
    fi
    exec zsh
}

function all_config() {
    print_echo "正在进行一些程序的配置..."
    print_echo "正在创建 atuin配置文件"
    # XDG 目录规范
    local atuin_config_dir="$XDG_CONFIG_HOME/atuin"
    local atuin_config_file="$XDG_CONFIG_HOME/atuin/config.toml"
    local atuin_config_file_url="https://raw.githubusercontent.com/1trapbox/1box/main/configs/atuin/config.toml"
    # 目录不存在则创建
    if [ ! -d "$atuin_config_dir" ]; then
        mkdir -p "$atuin_config_dir"
    fi

    if (curl -sl "$atuin_config_file_url" > "$atuin_config_file"); then
        print_ok "atuin 配置文件下载成功\n 路径=$atuin_config_file"
    else
        print_error "$atuin_config_file 重写失败"
    fi

    # starship
    print_echo "正在创建 starship 配置文件..."
    # XDG 目录规范
    local starship_config_dir="$XDG_CONFIG_HOME/starship"
    local starship_config_file="$XDG_CONFIG_HOME/starship/my_starship.toml"
    local starship_config_file_url="https://raw.githubusercontent.com/1trapbox/1box/main/configs/starship/my_starship.toml"

    # 目录不存在则创建
    if [ ! -d "$starship_config_dir" ]; then
        mkdir -p "$starship_config_dir"
    fi

    if (curl -sl "$starship_config_file_url" -o "$starship_config_file"); then
        print_ok "starship 配置文件下载成功\n 路径=$starship_config_file"
    else
        print_error "$starship_config_file 配置文件下载失败"
    fi
}

function set_zshenv() {
    # zsh无法正确启动XDG规范目录的.zshrc
    # 参考某国内大佬 https://blog.quarticcat.com/zh/posts/how-do-i-make-my-zsh-smooth-as-fuck/
    # 某stackoverflow https://stackoverflow.com/questions/21162988/how-to-make-zsh-search-configuration-in-xdg-config-home
    # 某superuser问答 https://superuser.com/questions/1799400/xdg-base-directory-environment-variables-not-respected-by-notionally-compliant-s
    print_echo "正在创建.zshenv"
    local zshenv_file="$HOME/.zshenv"
    # 检查文件是否存在
    if [ ! -e "$zshenv_file" ]; then
        # 如果文件不存在，则创建
        touch "$zshenv_file"
        print_ok ".zshenv已创建 路径=$zshenv_file"
    else
        print_ok ".zshenv已存在 路径=$zshenv_file"
    fi

    # 使用 tee 和 Here Document 写入内容
    print_echo "正在重写.zshenv"
    if (tee "$zshenv_file" > /dev/null <<EOF
# 环境变量 - XDG目录规范
export XDG_CONFIG_HOME="$HOME/.config"                  # 用户 特定配置的目录（类似于 /etc）
export XDG_CACHE_HOME="$HOME/.cache"                    # 用户 指定的非必要（缓存）数据的写入位置（类似于 /var/cache）
export XDG_DATA_HOME="$HOME/.local/share"               # 用户 特定数据文件的写入位置（类似于 /usr/share）
export XDG_STATE_HOME="$HOME/.local/state"              # 用户 特定状态文件应写入的位置（类似于 /var/lib）
export XDG_DATA_DIRS="/usr/local/share"                 # 全局 存储数据文件
export XDG_CONFIG_DIRS="/etc/xdg"                       # 全局 默认配置文件
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"                   # zsh指定配置文件目录 (放至.zshenv)

# 环境变量 - asdf XDG目录规范
# npm config ls -l | grep /
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/       # npm指定配置文件目录 - 用户 --userconfig
export NPM_CONFIG_GLOBALCONFIG=$XDG_CONFIG_HOME/npm     # npm指定配置文件目录 - 全局 --globalconfig
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm
export NPM_init-module
EOF
    ); then
        print_ok "覆盖重写成功 \n 路径=$zshenv_file 覆盖重写成功"
    else
        print_error "覆盖重写失败 \n 路径=$zshenv_file 覆盖重写成功"
    fi
}

update_system
install_packages
install_ohmyzsh
all_config
re_zshrc
set_zshenv
install_zinit
