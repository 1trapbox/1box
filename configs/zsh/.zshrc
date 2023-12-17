## 全新zshrc
## 更新时间: 2023-12-16

# 环境变量
export ZSH="$HOME/.oh-my-zsh"                   # ohmyzsh安装路径

# 环境变量 - XDG目录规范
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/"

# 快捷键
# zsh实时自动补全设置 @marlonrichert/zsh-autocomplete
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# alias设置
alias hh="tr ':' '\n'"                          # 换行 拼音hh
alias hist="atuin"                              # 列出历史记录的目录（默认：所有目录）
alias fd="fdfind -H"                            # 更好的find -H显示隐藏文件
alias cl="clear"                                # 洁癖
alias zshconfig="nano ~/.zshrc"                 # 打开zsh配置文件
alias toptop="glances"                          # 系统管理器
alias proxy4="proxychains4"                     # 代理
alias neofetch="neofetch"                       # neofetch系统信息
alias nginxconf="cd /opt/nginx/conf"            # nginx目录
alias xrayconf="cd /usr/local/etc/xray/"        # xray配置文件目2录
alias acme.sh=~/.acme.sh/acme.sh                # acme证书
alias sourcezsh='source ~/.zshrc'               # 刷新zsh
alias setproxy='export http_proxy=http://192.168.0.168:10809; export https_proxy=http://192.168.0.168:10809'

# alias设置 - 解压缩
alias gz='tar -xzvf'                            # gz解压缩
alias tar='tar -xzvf'                           # tar解压缩
alias zip='unzip'                               # zip解压缩
alias bz2='tar -xjvf'                           # bz2解压缩

# alias设置 - exa
alias ls='eza -la --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M"'                             # 显示所有文件，包括隐藏文件
alias la='eza -la --icons --tree --sort=type --git --time-style="+%Y/%m/%d %H:%M"'                      # 显示所有文件，包括隐藏文件，显示目录下的文件(--tree) 包括隐藏文件
alias ll='eza -la --icons --links --sort=type --git --time-style="+%Y/%m/%d %H:%M"'                     # 显示所有文件，包括隐藏文件，显示每个文件的硬链接
alias lb='eza -la --icons -r - --sort=size --git --time-style="+%Y/%m/%d %H:%M"-iso'                    # 大小排列
alias l.='eza -la --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M" -d .*'                       # 仅显示当前目录下的隐藏(.文件)
alias ld='eza -la --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M" -D'                          # 仅列出目录

# alias设置 - bat
alias bat="bat --paging=never"
alias cat="bat --paging=never"                                                                          # bat替代cat
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'                                            # 全局-h 使用bat输出
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'                                    # 全局--help 使用bat输出

# alias设置 - zinit
alias zup='zinit self-update'                                                                           # 更新zinit本身
alias zupall='zinit update'                                                                             # 更新zinit安装的软件包

# oh-my-zsh 设置 取消=注释即可
CASE_SENSITIVE="true"                           # 使用区分大小写的自动补全
HYPHEN_INSENSITIVE="true"                       # 使用不区分连字符的自动补全
zstyle ':omz:update' mode auto                  # 自动更新行为:自动
ENABLE_CORRECTION="true"                        # 启用命令自动更正
HIST_STAMPS="mm/dd/yyyy"                        # 历史记录显示日期
#HISTFILE=~/.zsh_history                        # 历史记录文件路径
#DISABLE_MAGIC_FUNCTIONS="true"                 # 如果粘贴URL和其他文本时出现混乱 取消注释
#DISABLE_AUTO_TITLE="true"                      # 禁止自动设置终端标题

# zinit 手动安装代码片段(官方默认)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# 一些程序
zinit light zdharma-continuum/zinit-annex-binary-symlink        # 🌟依赖 zinit 附件二进制符号链接
zinit load asdf-vm/asdf                                         # asdf版本管理器

zinit from"gh-r" lbin for @eza-community/eza                    # 维护更勤快的exa
zinit from"gh-r" lbin for @sharkdp/bat                          # 替代cat
zinit from"gh-r" lbin"rg" for @BurntSushi/ripgrep               # rg

zinit from"gh-r" lbin for @atuinsh/atuin                        # atuin/shell的云同步历史记录
eval "$(atuin init zsh)"                                        # atuin zsh小部件

zinit from"gh-r" lbin"starship" for @starship/starship          # starship
eval "$(starship init zsh)"                                     # starship 导入zsh
export STARSHIP_CONFIG=$HOME/.config/starship/my_starship.toml  # starship 配置文件

# zsh一些插件
zinit light zdharma-continuum/fast-syntax-highlighting          # zinit 语法高亮
zinit light zsh-users/zsh-completions                           # zsh自动补全 其他补充
zinit light marlonrichert/zsh-autocomplete                      # zsh实时自动补全
zinit light jeffreytse/zsh-vi-mode                              # zsh更好的vi(vim)模式插件
zinit light MichaelAquilina/zsh-you-should-use                  # zsh 你应该使用alias
#zinit light zsh-users/zsh-autosuggestions                       # zsh自动补全

