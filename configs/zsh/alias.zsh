# zsh shell
# alias 设置
# 2024-01-19

# alias设置 - 个人
alias xcopy="xclip -selection clipboard"                # 使用xclip复制到系统粘贴板
alias hh="tr ':' '\n'"                                  # 换行 拼音hh
alias hist="atuin"                                      # 列出历史记录的目录（默认：所有目录）
alias fd="fd -H -c=always"                              # 更好的find -H显示隐藏文件, 永远显示颜色
alias cl="clear"                                        # 洁癖
alias zshconfig="nano $HOME/.zshrc"                     # 打开zsh配置文件
alias toptop="glances"                                  # 系统管理器
alias proxy4="proxychains4"                             # 代理
alias neofetch="neofetch"                               # neofetch系统信息
alias nginxconf="cd /opt/nginx/conf"                    # nginx目录
alias xrayconf="cd /usr/local/etc/xray/"                # xray配置文件目2录
alias acme.sh=~/.acme.sh/acme.sh                        # acme证书
alias sourcezsh="source $HOME/.zshrc"                   # 刷新zsh
alias setproxy='export http_proxy=http://127.0.0.1:10809; export https_proxy=http://127.0.0.1:10809'
alias zshrcup="cp $HOME/.zshrc $HOME/.zshrc.bak && echo "备份.zshrc成功" && curl -sL https://raw.githubusercontent.com/1trapbox/1box/main/configs/zsh/.zshrc -o $HOME/.zshrc && "echo 更新.zshrc成功" "

# alias设置 - 解压缩
alias gz='tar -xzvf'                                    # gz解压缩
alias tar='tar -xzvf'                                   # tar解压缩
alias zip='unzip'                                       # zip解压缩
alias bz2='tar -xjvf'                                   # bz2解压缩

# alias设置 - exa
alias ls='eza -ls --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M"'              # 显示文件
alias la='eza -la --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M"'              # 显示所有文件，包括隐藏文件，显示目录下的文件(--tree) 包括隐藏文件
alias ll='eza -la --icons --links --sort=type --git --time-style="+%Y/%m/%d %H:%M"'      # 显示所有文件，包括隐藏文件，显示每个文件的硬链接
alias lb='eza -la --icons -r - --sort=size --git --time-style="+%Y/%m/%d %H:%M"-iso'     # 大小排列
alias l.='eza -la --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M" -d .*'        # 仅显示当前目录下的隐藏(.文件)
alias ld='eza -la --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M" -D'           # 仅列出目录

# alias设置 - bat
alias bat="bat --paging=never"
alias cat="bat --paging=never"                                                           # bat替代cat
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'                             # 全局-h 使用bat输出
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'                     # 全局--help 使用bat输出

# alias设置 - zinit
alias ziup='zinit self-update'                                                           # 更新zinit本身
alias ziupall='zinit update'                                                             # 更新zinit安装的软件包