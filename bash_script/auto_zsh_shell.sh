#! /bin/bash
# 用于安装zsh以及配置zsh
# 更新日期：2023-9-21

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
    ok="${ok_style}${bold}[OK 成功]${font}"
    echo -e "${ok}"
    echo -e "${green}${bold}$1${font}\n"
}

function print_error() {
    error="${error_style}${bold}[ERROR 失败]${font}"
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
        curl curl\n
        wget wget\n
        git git\n
        neofetch 系统信息\n
        bat 更好的cat\n
        exa 更好的ls\n
        zsh zsh\n
        fonts-firacode fira编程字体\n
        "
    sleep 2
    if (sudo apt install -y \
        curl \
        wget \
        git \
        exa \
        bat \
        zsh \
        fonts-firacode \
        ); then
        print_ok "软件包 安装成功"
    else
        print_error "软件包 安装失败"
    fi
}

function install_ohmyzhs() {
    print_echo "正在安装ohmyzsh..."
    sleep 2
    if (yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"); then
        print_ok "ohmyzsh 安装成功"
    else
        print_error "ohmyzsh 安装失败"
    fi

    print_echo "正在将zsh设置为默认shell..."
    sleep 2
    if (chsh -s $(which zsh)); then
        print_ok "设置zsh为默认shell 成功"
    else
        print_error "设置zsh为默认shell 失败"
    fi
}

function rewrite_zshrc() {
    print_echo "正在重写.zshrc配置文件..."
    sleep 2
    local remote_file="https://raw.githubusercontent.com/1trapbox/1box/main/zsh/.zshrc"
    local local_file="$HOME/.zshrc"

    # 下载远程文件并写入到本地文件
    if curl -sSL "$remote_file" > "$local_file"; then
        print_ok "$local_file 重写成功"
    else
        print_error "$local_file 重写失败"
    fi
}

function create_starship_config() {
    print_echo "正在创建starship配置文件..."
    sleep 2
    local config_dir="$HOME/.config"
    local config_file="$config_dir/my_starship.toml"
    local remote_file="https://raw.githubusercontent.com/1trapbox/1box/main/starship/starship.toml"

    # 检查配置目录是否存在，如果不存在则创建
    if [ ! -d "$config_dir" ]; then
        mkdir -p "$config_dir"
        print_echo "$config_dir 创建目录成功"
    else
        print_ok "$config_dir 目录已存在"
    fi

    # 下载远程文件并写入到本地文件
    if curl -sSL "$remote_file" > "$config_file"; then
        print_ok "$config_file 创建并重写成功"
    else
        print_error "$config_file 创建或重写失败"
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

    # 验证zinit是否成功安装
    if (zsh -c "zinit version"); then
        print_ok "zinit安装... 成功"
    else
        print_error "zinit安装... 失败"
    fi
}



update_system
install_packages
install_ohmyzhs
rewrite_zshrc
create_starship_config
install_zinit
