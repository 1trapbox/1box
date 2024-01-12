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


function install_ohmybash() {
    print_echo "正在安装oh-my-bash(XDG目录规范)"
    local XDG_DATA_HOME="$HOME/.local/share"
    if (
    export OSH="$XDG_DATA_HOME/oh-my-bash"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
    ); then
    print_ok "ohmyzsh安装成功 \n 路径=$XDG_DATA_HOME/oh-my-bash"
    fi
}

function bash_xdg() {
    # .bashrc文件路径
    local XDG_CONFIG_HOME="$HOME/.config"
    local bash_xdg_dir="$XDG_CONFIG_HOME/bash"
    local bashrc_config="$HOME/.bashrc"
    local bash_dot_files
    bash_dot_files=$(find "$HOME" -maxdepth 1 -type f -name '.bash*')

    print_echo "正在删除$HOME 目录下所有.bash开头的点文件"
    # 删除$HOME目录所有.bash开头点文件
    if (echo "$bash_dot_files" | xargs -d '\n' rm -v); then
    print_ok "$删除成功 所有$HOME/目录下所有.bash开头文件 \n 文件列表= \n $bash_dot_files"
    else
    print_error "$删除失败 所有$HOME/目录下所有.bash开头文件 \n 文件列表= \n $bash_dot_files"
    fi

    # 创建$XDG_CONFIG_HOME/bash
    if [ ! -d "$bash_xdg_dir" ]; then
    mkdir -p "$bash_xdg_dir"
    fi

    # 重写.zshrc
    local bash_config_file_url="https://raw.githubusercontent.com/1trapbox/1box/main/configs/bash/.bashrc"
    if (curl -sl "$bash_config_file_url" > "$bashrc_config"); then
        print_ok ".bashrc 配置文件下载重写成功 \n 路径=$bashrc_config"
    else
        print_error ".bashrc 配置文件下载重写失败 \n 路径=$bashrc_config"
    fi
    source ~/.bashrc
}

install_ohmybash
bash_xdg