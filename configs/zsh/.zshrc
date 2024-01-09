## .zshrc
## 更新时间: 2024-1-7

# 环境变量
export ZSH="$HOME/.oh-my-zsh"                   # ohmyzsh安装路径

# 服务器环境变量
#. "/root/.acme.sh/acme.sh.env"                  # acme.sh环境变量

# 环境变量 - XDG目录规范
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/"

# alias设置
alias xcopy="xclip -selection clipboard"        # 使用xclip复制到系统粘贴板
alias hh="tr ':' '\n'"                          # 换行 拼音hh
alias hist="atuin"                              # 列出历史记录的目录（默认：所有目录）
alias fd="fd -H"                                # 更好的find -H显示隐藏文件
alias cl="clear"                                # 洁癖
alias zshconfig="nano ~/.zshrc"                 # 打开zsh配置文件
alias toptop="glances"                          # 系统管理器
alias proxy4="proxychains4"                     # 代理
alias neofetch="neofetch"                       # neofetch系统信息
alias nginxconf="cd /opt/nginx/conf"            # nginx目录
alias xrayconf="cd /usr/local/etc/xray/"        # xray配置文件目2录
alias acme.sh=~/.acme.sh/acme.sh                # acme证书
alias sourcezsh='source ~/.zshrc'               # 刷新zsh
alias setproxy='export http_proxy=http://127.0.0.1:10809; export https_proxy=http://127.0.0.1:10809'
alias zshrcup='mv ~/.zshrc ~/.zshrc.bak && echo "备份.zshrc成功" && curl -s https://raw.githubusercontent.com/1trapbox/1box/main/configs/zsh/.zshrc -o ~/.zshrc && echo "更新.zshrc成功"'

# alias设置 - 解压缩
alias gz='tar -xzvf'                            # gz解压缩
alias tar='tar -xzvf'                           # tar解压缩
alias zip='unzip'                               # zip解压缩
alias bz2='tar -xjvf'                           # bz2解压缩

# alias设置 - exa
alias ls='eza -ls --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M"'                             # 显示文件
alias la='eza -la --icons --sort=type --git --time-style="+%Y/%m/%d %H:%M"'                      # 显示所有文件，包括隐藏文件，显示目录下的文件(--tree) 包括隐藏文件
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

# asdf 安装的一些环境变量
export PATH="$PATH:$HOME/.local/bin"                            # pipx bin $PATH
eval "$(register-python-argcomplete pipx)"                      # pipx    shell自动补全
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"                    # pipenv  shell自动补全
#export GOPATH=$(go env GOPATH)                                  # GOPATH form go env
#export GOROOT=$(go env GOROOT)                                  # GOROOT form go env
#export PATH="$PATH:$GOPATH/bin"                                 # GO BIN二进制


# 插件@zinit-annex-binary-symlink
zinit from"gh-r" lbin"!eza" for @eza-community/eza              # 维护更勤快的exa
zinit from"gh-r" lbin"!bat" for @sharkdp/bat                    # 替代cat
zinit from"gh-r" lbin"!rg" for @BurntSushi/ripgrep              # rg
zinit from"gh-r" lbin"!fd" for @sharkdp/fd                      # fd
zinit from"gh-r" lbin"!nvim" for @neovim/neovim                 # 使用nvim
zinit from"gh-r" lbin"!navi" for @denisidoro/navi               # navi 备忘录
zinit from"gh-r" lbin"!fzf" for junegunn/fzf                    # fzf
zinit from"gh-r" lbin"!glow" for charmbracelet/glow             # 在 CLI 上渲染 Markdown

# 插件@zinit-annex-binary-symlink 带参数的
zinit from"gh-r" lbin"!atuin" for @atuinsh/atuin                # atuin/shell的云同步历史记录
eval "$(atuin init zsh)"                                        # atuin zsh小部件
bindkey '^r' _atuin_search_widget                               # ctrl+r 快捷键

zinit from"gh-r" lbin"!starship" for @starship/starship         # starship
eval "$(starship init zsh)"                                     # starship 导入zsh
export STARSHIP_CONFIG=$HOME/.config/starship/my_starship.toml  # starship 配置文件

# 一些ice
#zinit ice as"command" pick"xdg-ninja.sh"                        # xdg忍者 检查 $HOME 中是否有不需要的文件和目录
#zinit load b3nj5m1n/xdg-ninja                                   # xdg忍者
#alias xdgnj=xdg-ninja.sh                                        # xdg忍者 lias
#export XDG_STATE_HOME="$HOME/.local/state"                      # xdg忍者 PATH

# zsh实时自动补全设置 @marlonrichert/zsh-autocomplete
zinit light marlonrichert/zsh-autocomplete                      # zsh实时自动补全
#zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
#zstyle ':autocomplete:*history*:*' insert-unambiguous yes
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

() {
    local -a prefix=( '\e'{\[,O} )
    local -a up=( ${^prefix}A ) down=( ${^prefix}B )
    local key=
    for key in $up[@]; do
        bindkey "$key" _atuin_search_widget
    done
#    for key in $down[@]; do
#        bindkey "$key" _atuin_search_widget
#    done
}

# 一些light插件
zinit light zdharma-continuum/fast-syntax-highlighting          # zinit 语法高亮
zinit light zsh-users/zsh-completions                           # zsh自动补全 其他补充
zinit light jeffreytse/zsh-vi-mode                              # zsh更好的vi(vim)模式插件
zinit light MichaelAquilina/zsh-you-should-use                  # zsh 你应该使用alias
#zinit light zsh-users/zsh-autosuggestions                       # zsh自动补全