#! /bin/bash
# 用于安装zsh以及配置zsh
# 更新日期：2023-12-17

# ANSI 颜色代码
font="\033[0m"
bold="\033[1m"
green="\033[32m"
red="\033[31m"
yellow="\033[33m"
error_style="\033[37;41m"
ok_style="\033[37;42m"


# 简单的输出
function print_ok() {
    ok="${ok_style}${bold}[OK]${font}"
    echo -e "${ok}"
    echo -e "${green}${bold}$1${font}\n"
}

function print_error() {
    error="${error_style}${bold}[ERROR]${font}"
    echo -e "${error}"
    echo -e "${red}${bold}$1${font}\n"
}

function print_echo() {
    echo -e "${yellow}${bold}$1${font}\n"
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
        neofetch 系统信息\n
        fonts-firacode fira编程字体\n
        "
    sleep 2
    if (sudo apt install -y \
        curl \
        wget \
        git \
        zsh \
        unzip \
        neofetch \
        fonts-firacode \
        ); then
        print_ok "软件包 安装成功"
    else
        print_error "软件包 安装失败"
    fi
}

function install_ohmyzsh() {
    print_echo "正在安装ohmyzsh..."
    sleep 2
    if (yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"); then
        print_ok "ohmyzsh 安装成功"
    else
        print_error "ohmyzsh 安装失败"
    fi

    print_echo "正在将zsh设置为默认shell..."
    sleep 2
    if chsh -s "$(which zsh)"; then
        print_ok "设置zsh为默认shell 成功"
    else
        print_error "设置zsh为默认shell 失败"
    fi
}


function re_zshrc() {
    print_echo "正在重写".zshrc"配置文件..."
    sleep 2
    local zshrc_config_file="$HOME/.zshrc"
    local zshrc_config_file_url="https://raw.githubusercontent.com/1trapbox/1box/main/configs/zsh/.zshrc"
    if [ -e "$zshrc_config_file" ]; then
        # 如果文件存在，则重写所有内容
        curl -s "$zshrc_config_file_url" > "$zshrc_config_file"
        print_ok "zshrc 配置文件已重写成功\n 路径=$zshrc_config_file"
    else
        # 如果文件不存在，则创建并写入内容
        touch "$HOME/.zshrc"
    if (curl -s "$zshrc_config_file_url" > "$zshrc_config_file"); then
        print_ok "starship 配置文件创建并重写成功\n 路径=$zshrc_config_file"
    else
        print_error "$zshrc_config_file 重写失败"
    fi
    fi

}

function install_zinit() {
    print_echo "正在安装zinit (手动安装模式)..."
    sleep 2
    # 重新加载 Zsh 以安装 Zinit：
    if exec zsh; then
    print_echo "重新加载zsh以安装zinit... 成功"
    else
    print_error "重新加载zsh以安装zinit... 失败"
    fi
    source ~/.zshrc
}

function all_config() {
    print_echo "正在进行一些程序的配置"
    sleep 2

    print_echo "正在创建"atuin"配置文件"
    sleep 2
    local atuin_config_file="$HOME/.config/atuin/config.toml"
    local atuin_config_file_url="https://raw.githubusercontent.com/1trapbox/1box/main/configs/atuin/config.toml"
    if [ -e "$atuin_config_file" ]; then
        # 如果文件存在，则重写所有内容
        curl -s "$atuin_config_file_url" > "$atuin_config_file"
        print_ok "atuin 配置文件已重写成功\n 路径=$atuin_config_file"
    else
        # 如果文件不存在，则创建并写入内容
        mkdir -p "$HOME/.config/atuin"
    if (curl -s "$atuin_config_file_url" > "$atuin_config_file") ;then
        print_ok "atuin 配置文件创建并重写成功\n 路径=$atuin_config_file"
    else
        print_error "$atuin_config_file 重写失败"
    fi
    fi
    # starship
    # shellcheck disable=SC2140
    print_echo "正在创建"starship"配置文件..."
    sleep 2
    local starship_config_file="$HOME/.config/starship/my_starship.toml"
    local starship_config_file_url="https://raw.githubusercontent.com/1trapbox/1box/main/configs/starship/my_starship.toml"
    if [ -e "$starship_config_file" ]; then
        # 如果文件存在，则重写所有内容
        curl -s "$starship_config_file_url" > "$starship_config_file"
        print_ok "starship 配置文件已重写成功\n 路径=$starship_config_file"
    else
        # 如果文件不存在，则创建并写入内容
        mkdir -p "$HOME/.config/starship"
    if (curl -s "$starship_config_file_url" > "$starship_config_file") ;then
        print_ok "starship 配置文件创建并重写成功\n 路径=$starship_config_file"
    else
        print_error "$starship_config_file 重写失败"
    fi
    fi
}

update_system
install_packages
install_ohmyzsh
all_config
re_zshrc
install_zinit
