#! /bin/bash
# 使用asdf安装java, python, nodejs, pipx, go...
# 更新日期：2024-1-14

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
    sleep 8
}

function print_error() {
    # 重定向错误信息到日志文件 
    exec 2>> /tmp/error.txt
    # 记录当前函数名
    echo "From function: ${FUNCNAME[1]}" >> error.txt
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

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
function depend() {
    print_echo "安装python的依赖..."
    if (sudo apt update && sudo apt install -y \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev); then
    print_ok "python依赖安装成功"
    else
    print_error "python依赖安装失败"
    fi

    print_echo "安装nodejs的依赖..."
    if (sudo apt install -y \
    dirmngr gpg curl gawk); then
    print_ok "nodejs依赖安装成功"
    else
    print_error "nodejs依赖安装失败"
    fi

    print_echo "安装go的依赖..."
    if (sudo apt install -y \
    curl coreutils); then
    print_ok "go依赖安装成功"
    else
    print_error "go依赖安装失败"
    fi
}

function install_all() {

    # nodejs npm
    print_echo "正在安装nodejs"
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    print_echo "添加nodejs插件成功"
    if (asdf install nodejs latest); then
    print_ok "nodejs安装成功"
    else
    print_error "nodejs安装失败"
    fi

    if (asdf global nodejs latest); then
    node_version=$(node --version)
    npm_version=$(npm --version)
    print_echo "nodejs(latest) 设置全局版本成功 \n node $node_version \n npm $npm_version"
    fi


    # java
    print_echo "正在安装graalvm(java)"
    asdf plugin-add java https://github.com/halcyon/asdf-java.git
    print_echo "添加java插件成功"
    if (asdf install java oracle-graalvm-21.0.1); then
    print_ok "oracle-graalvm(java)安装成功"
    else
    print_error "oracle-graalvm(java)安装失败"
    fi

    if (asdf global java oracle-graalvm-21.0.1); then
    java_version=$(java --version | rg java)
    print_echo "oracle-graalvm(java)设置全局版本成功 \n $java_version"
    fi

    # python
    print_echo "正在安装python"
    asdf plugin-add python
    print_echo "添加python插件成功"
    if (asdf install python latest); then
    print_ok "python安装成功"
    else
    print_error "python安装失败"
    fi

    if (asdf global python latest); then
    python_version=$(python --version)
    pip_version=$(pip --version)
    print_echo "python(latest) 设置全局版本成功 \n $python_version \n $pip_version"
    fi

    # pipx
    print_echo "正在安装pipx"
    asdf plugin add pipx
    print_echo "添加pipx插件成功"
    if (asdf install pipx latest); then
    print_ok "pipx安装成功"
    else
    print_error "python安装失败"
    fi

    if (asdf global pipx latest); then
    pipx_version=$(pipx --version)
    print_echo "pipx(latest) 设置全局版本成功 \n pipx $pipx_version"
    fi

    # pipx install argcomplete shell补全
    if (pipx install argcomplete); then
    print_ok "pipx安装argcomplete成功"
    else
    print_error "pipx安装argcomplete失败"
    fi

    # pipx install pipenv
    if (pipx install pipenv); then
    print_ok "pipx安装pipenv成功"
    else
    print_error "pipx安装pipenv失败"
    fi
    

    # go
    print_echo "正在安装go"
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
    print_echo "添加go插件成功"
    if (asdf install golang latest); then
    print_ok "go安装成功"
    else
    print_error "go安装失败"
    fi

    if (asdf global golang latest); then
    go_version=$(go version)
    print_echo "go(latest) 设置全局版本成功 \n $go_version"
    fi

    # go GO111MODULE=auto
    if (go env -w GO111MODULE=auto);then
    print_ok "GO111MODULE=auto 设置成功"
    else
    print_error "GO111MODULE=auto 设置失败"
    fi
}

function modify_zshrc() {
    # 定义一些变量
    zshrc_file="$HOME/.zshrc"
    search_line="zinit load asdf-vm/asdf"
    line_number=$(grep -n "$search_line" "$zshrc_file" | cut -d: -f1)
    # 将内容存储在tmpfile
    tmpfile=$(sudo mktemp)
    sudo tee "$tmpfile" <<'EOF'
# asdf 安装的一些环境变量
export PATH="$PATH:$HOME/.local/bin"                            # pipx bin $PATH
eval "$(register-python-argcomplete pipx)"                      # pipx    shell自动补全
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"                    # pipenv  shell自动补全
#export GOPATH=$(go env GOPATH)                                 # GOPATH form go env
#export GOROOT=$(go env GOROOT)                                 # GOROOT form go env
#export PATH="$PATH:$GOPATH/bin"                                # GO BIN二进制
EOF


    # 搜索匹配的行
    if grep -q "$search_line" "$zshrc_file"; then
    # 在匹配行的下一行插入内容
        sudo sed -i "${line_number}r ${tmpfile}" "${zshrc_file}"
        print_ok "修改 $zshrc_file 成功"
    else
        print_error "修改 $zshrc_file 失败"
    fi
}
function for_xdg() {
    print_echo "配置XDG规范目录"
    # XDG 目录规范
    local XDG_CONFIG_HOME="$HOME/.config"
    local XDG_CACHE_HOME="$HOME/.cache"
    local XDG_DATA_HOME="$HOME/.local/share"
    local XDG_STATE_HOME="$HOME/.local/state"
    local XDG_DATA_DIRS="/usr/local/share"
    local XDG_CONFIG_DIRS="/etc/xdg"
    # npm配置xdg规范目录
    local npm_config_dir="$XDG_CONFIG_HOME/npm"
    # 目录不存在则创建
    if [ ! -d "$npm_config_dir" ]; then
        mkdir -p "$npm_config_dir"
    fi

    if (curl -sl "$starship_config_file_url" -o "$starship_config_file"); then
        print_ok "starship 配置文件下载成功\n 路径=$starship_config_file"
    else
        print_error "$starship_config_file 配置文件下载失败"
    fi

}




depend
install_all
modify_zshrc