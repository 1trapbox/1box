#! /bin/bash
# 用于设置语言编码和安装字体
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

function set_language() {
    # 检查是否已经安装了英文语言包
    print_echo "正在安装英文语言包..."
    sudo apt install -y language-pack-en
    sleep 2

    # 检查是否已经安装了中文语言包
    print_echo "正在安装中文语言包..."
    sudo apt install -y language-pack-zh-hans
    sleep 2 

    # 设置英文为默认语言
    print_echo "正在设置英文为默认语言..."
    if (sudo update-locale LANG=en_US.UTF-8); then
        source /etc/default/locale
        print_ok "设置英文为默认语言 成功"
    else
        print_error "设置英文为默认语言 失败"
    fi
}

function install_font() {
    # 安装更纱黑体 Sarasa Gothic
    sarasa_gothic_latest_version=$(curl -s https://api.github.com/repos/be5invis/Sarasa-Gothic/releases/latest | grep 'tag_name' | cut -d '"' -f 4 | sed 's/^v//')
    sarasa_gothic_font_filename="sarasa-gothic-super-ttc-${sarasa_gothic_latest_version}.7z"
    sarasa_gothic_font_url="https://github.com/be5invis/Sarasa-Gothic/releases/download/v${sarasa_gothic_latest_version}/${sarasa_gothic_font_filename}"
    print_echo "正在安装"更纱黑体"字体..."
    # 7z解压缩
    sudo apt-get install p7zip-full -y

    if (curl -L -o /tmp/${sarasa_gothic_font_filename} ${sarasa_gothic_font_url}); then
        print_echo "下载"更纱黑体"字体成功"
    else
        print_error "下载"更纱黑体"字体失败"
    fi
    sleep 10
    # 解压字体
    if (cd /tmp && 7z x /tmp/${sarasa_gothic_font_filename}); then
        print_echo "${sarasa_gothic_font_filename} 解压成功"
    else
        print_error "${sarasa_gothic_font_filename} 解压失败"
    fi
    # 安装字体
    if (sudo cp /tmp/*.ttc /usr/share/fonts/); then
    sudo fc-cache -f -v
        print_echo "安装"更纱黑体"字体 成功"
    else
        print_error "安装"更纱黑体"字体 失败"
    fi
    # 删除缓存文件
    sudo rm -rf /tmp/$sarasa_gothic_font_filename
    sudo rm -rf /tmp/*.ttc
}

set_language
install_font