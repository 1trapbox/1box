#! /bin/bash
# 更新日期：2023-12-18
# 用于安装nginx
# 解决了nginx安装后目录下多个文件夹混乱的问题

# ANSI 颜色代码
font="\033[0m"
bold="\033[1m"
green="\033[32m"
red="\033[31m"
yellow="\033[33m"
error_style="\033[37;41m"
ok_style="\033[37;42m"

# env
nginx_install_path="/opt/nginx"
nginx_download_path="/opt"
nginx_bak_path="/opt/nginx_bak"
nginx_file="/usr/local/bin/nginx"
nginx_service_file="/etc/systemd/system/nginx.service"
current_datetime="$(date "+%Y-%m-%d-%H:%M")"
nginx_bak_file_name="${current_datetime}_nginx_conf.bak"
nginx_bak_file_path="$nginx_bak_path/$nginx_bak_file_name"
latest_version=$(curl -s https://nginx.org/en/download.html | grep -oP 'Mainline version.*?nginx-(.*?).tar.gz' | sed 's/.*nginx-//' | sed 's/.tar.gz.*//')
current_version=$(nginx -v 2>&1 | cut -d'/' -f2)

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
    
}

# 更新系统
function update_system_and_packages() {
    print_echo "准备更新系统/包..."
    if (sudo apt update && sudo apt upgrade -y); then
        print_ok "系统&包更新成功"
    else    
        print_error "系统&包更新失败"
    fi
    # 安装curl和wget
    if (sudo apt install -y \
        curl \
        wget \
        ); then  
    print_ok "安装成功 wget curl"
    else
    print_error "安装失败 wget curl"
    fi
}

# 安装nginx依赖
function install_nginx_dependencies() {
    print_echo "正在安装nginx依赖"
    if (sudo apt install -y \
        build-essential \
        libpcre2-dev \
        zlib1g-dev \
        libssl-dev \
        libxml2-dev \
        libgd-dev \
        libcurl4-openssl-dev \
        libnghttp2-dev \
        ); then
        print_ok "nginx依赖 安装成功"
    else
        print_error "nginx依赖 安装失败"
        sleep 5
    fi
}

# 下载nginx源代码
function install_nginx() {
    # 获取最新nginx Mainline version版本号
    print_echo "正在下载nginx(Mainline版本)源代码..."
    if print_echo "$latest_version"; then
        print_ok "获取成功 \n最新nginx(Mainline版本号): $latest_version"
    else
        print_error "获取失败 \n最新nginx(Mainline版本号): $latest_version"
    fi

    # 下载Nginx源码
    if (sudo wget -c https://nginx.org/download/nginx-"$latest_version".tar.gz -P $nginx_download_path); then
        print_ok "nginx下载成功 \n路径: $nginx_download_path/nginx-$latest_version"
    else
        print_error "nginx下载失败 \n路径: $nginx_download_path/nginx-$latest_version"
    fi

    # 解压源码
    if (sudo tar -C "$nginx_download_path" -zxvf "$nginx_download_path"/nginx-"$latest_version".tar.gz); then
        print_ok "解压成功\n nginx-$latest_version.tar.gz"
    else
        print_error "解压失败\n nginx-$latest_version.tar.gz"
    fi
}

# 编译nginx
function compile_nginx() {
    # 创建 $nginx_install_path 目录
    print_echo "正在创建nginx目录..."
    if (sudo mkdir -p $nginx_install_path); then
        print_ok "创建nginx目录成功 \n路径=$nginx_install_path"
    else
        print_error "创建目录失败 \n路径=$nginx_install_path"
    fi

    # 创建 $nginx_install_path/子目录
    print_echo "正在创建nginx/子目录..."
    # 创建 $nginx_install_path/temp 目录
    if (sudo mkdir -p $nginx_install_path/temp); then
        print_ok "创建目录成功 \n路径=$nginx_install_path/temp"
    else
        print_error "创建目录失败 \n路径=$nginx_install_path/temp"
    fi

    # 创建 $nginx_install_path/run 目录
    if (sudo mkdir -p $nginx_install_path/run); then
        print_ok "创建目录成功 \n路径=$nginx_install_path/run"
    else
        print_error "创建目录失败 \n路径=$nginx_install_path/run"
    fi

    # 创建 $nginx_install_path/temp/client-body 目录
    if (sudo mkdir -p $nginx_install_path/temp/client-body); then
        print_ok "创建目录成功 \n路径=$nginx_install_path/temp/client-body"
    else
        print_error "创建目录失败 \n路径=$nginx_install_path/temp/client-body"
    fi

    # 创建 $nginx_install_path/temp/proxy 目录
    if (sudo mkdir -p $nginx_install_path/temp/proxy); then
        print_ok "创建目录成功 \n路径=$nginx_install_path/temp/proxy"
    else
        print_error "创建目录失败 \n路径=$nginx_install_path/temp/proxy"
    fi

    # 创建 $nginx_install_path/temp/fastcgi 目录
    if (sudo mkdir -p $nginx_install_path/temp/fastcgi); then
        print_ok "创建目录成功 \n路径=$nginx_install_path/temp/fastcgi"
    else
        print_error "创建目录失败 \n路径=$nginx_install_path/temp/fastcgi"
    fi

    # 创建 $nginx_install_path/temp/uwsgi 目录
    if (sudo mkdir -p $nginx_install_path/temp/uwsgi); then
        print_ok "创建目录成功 \n路径=$nginx_install_path/temp/uwsgi"
    else
        print_error "创建目录失败 \n路径=$nginx_install_path/temp/uwsgi"
    fi

    # 创建 $nginx_install_path/temp/scgi 目录
    if (sudo mkdir -p $nginx_install_path/temp/scgi); then
        print_ok "创建目录成功 \n路径=$nginx_install_path/temp/scgi"
    else
        print_error "创建目录失败 \n路径=$nginx_install_path/temp/scgi"
    fi

    # 创建 $nginx_install_path/conf/default 目录
    #if (mkdir -p $nginx_install_path/conf/default); then
    #    print_ok "创建目录成功 \n路径=$nginx_install_path/conf/default"
    #else
    #    print_error "创建目录失败 \n路径=$nginx_install_path/conf/default"
    #fi

    # 编译nginx
    print_echo "正在编译安装nginx..."
    cd $nginx_download_path/nginx-"$latest_version" || exit
    sudo ./configure \
        --prefix=$nginx_install_path \
        --pid-path=$nginx_install_path/run/nginx.pid \
        --lock-path=$nginx_install_path/run/nginx.lock \
        --http-client-body-temp-path=$nginx_install_path/temp/client-body \
        --http-proxy-temp-path=$nginx_install_path/temp/proxy \
        --http-fastcgi-temp-path=$nginx_install_path/temp/fastcgi \
        --http-uwsgi-temp-path=$nginx_install_path/temp/uwsgi \
        --http-scgi-temp-path=$nginx_install_path/temp/scgi \
        --with-http_sub_module \
        --with-http_ssl_module \
        --with-http_v2_module \
        --with-http_realip_module \
        --with-http_gzip_static_module \
        --with-stream \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module \
        --with-stream_realip_module \
        --with-http_stub_status_module \
    
    if (sudo make && sudo make install); then
        print_ok "nginx 编译成功"
    else
        print_error "nginx 编译失败"
    fi

    if (sudo make clean); then
        print_ok "make clean 运行成功"
    else
        print_error "make clean 运行失败"
    fi

    # 整理nginx/conf
    print_echo "正在整理nginx生成的默认配置文件"
    local tmpdir
    tmpdir=$(sudo mktemp -d)
    sudo chmod 777 "$tmpdir"
    # 移动到临时目录
    sudo mv $nginx_install_path/conf/* "$tmpdir/"
    # 创建default
    sudo mkdir -p $nginx_install_path/conf/default/
    # 从临时目录移动回来
    sudo mv "$tmpdir"/* $nginx_install_path/conf/default/
    # 删除临时目录
    sudo rm -rf "$tmpdir"
}

function create_nginx_conf() {
    print_echo "正在创建nginx配置文件..."
    tmpfile=$(sudo mktemp)
    sudo tee "$tmpfile" <<EOF
user nobody;
worker_processes auto;

events {
    worker_connections  2048;
}

EOF

    if sudo mv "$tmpfile" "$nginx_install_path/conf/nginx.conf"; then
        print_ok "创建nginx配置文件成功 \n路径=$nginx_install_path/conf/nginx.conf"
    else
        print_error "创建nginx配置文件失败 \n路径="$nginx_install_path/conf/nginx.conf
    fi
}

# 删除Nginx安装包
function remove_nginx_package() {
    print_echo "正在清理nginx安装残留..."
    # 删除nginx压缩文件
    if (sudo rm -rf $nginx_download_path/nginx-"$latest_version".tar.gz); then
        print_ok "删除nginx压缩文件成功 \n路径=$nginx_download_path/nginx-$latest_version.tar.gz"
    else
        print_error "删除nginx压缩文件失败 \n路径=$nginx_download_path/nginx-$latest_version.tar.gz"
    fi
    # 删除nginx解压后的目录
    if (sudo rm -rf $nginx_download_path/nginx-"$latest_version"); then
        print_ok "删除nginx解压后的目录成功 \n路径=$nginx_download_path/nginx-$latest_version"
    else
        print_error "删除nginx解压后的目录成功 \n路径=$nginx_download_path/nginx-$latest_version"
    fi
}

# 创建nginx服务文件
function create_nginx_service_file() {
    print_echo "正在创建nginx服务文件..."
    tmpfile=$(sudo mktemp)
    sudo chmod 777 "$tmpfile"
    cat > "$tmpfile" <<EOF
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=$nginx_install_path/run/nginx.pid
ExecStartPre=/usr/local/bin/nginx -t
ExecStart=/usr/local/bin/nginx
ExecReload=/usr/local/bin/nginx -s reload
ExecStop=/bin/kill -s QUIT \$MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
    if sudo mv "$tmpfile" "$nginx_service_file"; then
        print_ok "创建nginx服务文件成功 \n路径=$nginx_service_file"
    else
        print_error "创建nginx服务文件失败 \n路径=$nginx_service_file"
    fi
}

# 复制二进制文件到/usr/local/bin
function mv_nginx() {
    print_echo "正在移动nginx二进制文件..."
    if (sudo cp $nginx_install_path/sbin/nginx $nginx_file); then
        print_ok "移动nginx二进制文件成功 \n路径=$nginx_file"
    else
        print_error "移动nginx二进制文件失败 \n路径=$nginx_file"
    fi
}

# 检查和创建nobody用户组
function check_nobody_group() {
    print_echo "正在创建用户组nobody..."
    if sudo grep -q -E '^nobody:' /etc/group; then
        print_ok "用户组nobody已存在 无需创建"
    else
        sudo groupadd nobody
        print_ok "用户组nobody创建成功"
    fi
}

# 启动nginx服务
function start_nginx_service() {
    print_echo "正在启动nginx服务..."
    if (
        sudo systemctl daemon-reload;
        sudo systemctl restart nginx
    ); then
        print_ok "重启nginx服务成功"
    else
        print_error "重启nginx服务失败"
    fi
}

# 暂停nginx服务
function stop_nginx_service() {
    print_echo "正在暂停nginx服务..."
    if (sudo systemctl stop nginx); then
        print_ok "暂停nginx服务成功"
    else
        print_error "暂停nginx服务失败"
    fi
}

# 设置开机自启
function self_start_nginx_service() {
    print_echo "正在设置nginx开机自启服务..."
    if (sudo systemctl enable nginx); then
        print_ok "设置nginx开机自启服务成功"
    else
        print_error "设置nginx开机自启服务失败"
    fi
}

# 完整卸载nginx
function del_nginx() {
    print_echo "正在卸载nginx..."
    # 删除nginx目录
    if (sudo rm -rf "$nginx_install_path"); then
        print_ok "删除nginx目录成功 \n路径=$nginx_install_path"
    else
        print_error "删除nginx目录失败 \n路径=$nginx_install_path"
    fi
    # 删除nginx服务文件
    if (sudo rm -rf "$nginx_service_file"); then
        print_ok "删除nginx服务文件成功 \n路径=$nginx_service_file"
    else
        print_error "删除nginx服务文件失败 \n路径=$nginx_service_file"
    fi
    # 删除二进制文件
    if (sudo rm -rf "$nginx_file"); then
        print_ok "删除nginx二进制文件成功 \n路径=$nginx_file"
    else
        print_error "删除nginx二进制文件失败 \n路径=$nginx_file"
    fi
}

# 备份Nginx配置
function backup_nginx_config() {
    print_echo "正在备份nginx配置文件..."
    if (sudo cp -r $nginx_install_path/conf $nginx_bak_file_path); then
        print_ok "备份nginx配置文件成功 \n路径=$nginx_bak_file_path"
    else
        print_error "备份nginx配置文件失败 \n路径=$nginx_bak_file_path"
    fi
}

# 更新nginx
function update_nginx() {
    # 获取当前nginx版本
    print_echo "正在更新nginx..."
    print_echo "当前nginx版本: $current_version"
    print_echo "最新nginx版本: $latest_version"

    # 对比两者版本
    if [[ "$current_version" < "$latest_version" ]]; then
            print_echo "最新nginx版本=$latest_version 请选择是否更新"
            print_echo "1. 备份nginx配置文件 并且进行更新..."
            print_echo "2. 不进行备份nginx配置文件 直接进行更新..."

        read -r -p $'请输入1 or 2\n' choice
        
        echo -e "你的选择：$choice"
        case "$choice" in
        # 备份nginx配置文件 并且进行更新...
            1)
                stop_nginx_service
                backup_nginx_config
                del_nginx
                update_system_and_packages
                install_nginx
                compile_nginx
                create_nginx_conf
                remove_nginx_package
                mv_nginx
                check_nobody_group
                create_nginx_service_file
                start_nginx_service
                self_start_nginx_service
                ;;
        # 不进行备份nginx配置文件 直接进行更新...
            2)
                stop_nginx_service
                del_nginx
                update_system_and_packages
                install_nginx
                compile_nginx
                create_nginx_conf
                remove_nginx_package
                mv_nginx
                check_nobody_group
                create_nginx_service_file
                start_nginx_service
                self_start_nginx_service
                ;;
            *)
                print_error "错误 只能输入1 or 2"
                exit 1
                ;;
        esac
        # 检查更新是否成功
        if [[ "$current_version" == "$latest_version" ]]; then
            print_ok "nginx更新成功"
        else
            print_error "nginx更新失败"
        fi
    fi
}

# 菜单选项
function nginx_operation() {
            print_echo "请选择"
            print_echo "1. 安装nginx"
            print_echo "2. 卸载nginx"
            print_echo "3. 更新nginx"

    read -r -p $'请输入数字1 or 2 or 3\n' choice  # 在提示字符串中添加了换行符\n
    print_ok "你的选择：$choice"
    case "$choice" in
    # 安装Nginx
        1)
            # 更新系统
            update_system_and_packages
            # 安装nginx依赖
            install_nginx_dependencies
            # 下载nginx源代码
            install_nginx
            # 编译nginx
            compile_nginx
            # 删除Nginx安装包
            remove_nginx_package
            # 🆕创建nginx配置文件
            create_nginx_conf
            # 复制二进制文件到/usr/local/bin
            mv_nginx
            # 检查创建nobody用户组
            check_nobody_group
            # 创建nginx服务文件
            create_nginx_service_file
            # 启动nginx服务
            start_nginx_service
            # 设置nginx服务开机自启
            self_start_nginx_service
            ;;
    # 卸载Nginx
        2)
            # 卸载Nginx
            del_nginx
            ;;
    # 更新Nginx
        3)
            update_nginx
            ;;
        *)
            print_error "错误: 请输入数字1 or 2 or 3"
            exit 1
            ;;
    esac
}

nginx_operation