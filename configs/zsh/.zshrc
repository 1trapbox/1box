# 服务器使用
# 更新时间: 2023-11-28

# 环境变量
export ZSH="$HOME/.oh-my-zsh"                   # ohmyzsh安装路径
export PATH=$HOME/bin:/usr/local/bin:$PATH      # 系统变量

# alias设置
alias zshconfig="nano ~/.zshrc"                 # 打开zsh配置文件
alias toptop="glances"                          # 系统管理器
alias proxy4="proxychains4"                     # 代理
alias cat="batcat"                              # bat替代cat
alias neofetch="neofetch"                       # neofetch系统信息
alias nginxconf="cd /opt/nginx/conf"            # nginx目录
alias xrayconf="cd /usr/local/etc/xray/"        # xray配置文件目录
alias acme.sh=~/.acme.sh/acme.sh                # acme证书
alias sourcezsh='source ~/.zshrc'               # 刷新zsh  

# alias设置 - 解压缩
alias gz='tar -xzvf'                            # gz解压缩
alias tar='tar -xzvf'                           # tar解压缩
alias zip='unzip'                               # zip解压缩
alias bz2='tar -xjvf'                           # bz2解压缩

## alias设置 - exa
alias ls='exa'                                  # 将exa设置为ls的别名
alias ll='exa -l'                               # 列出详细信息
alias la='exa -a'                               # 显示所有文件，包括隐藏文件
alias l.='exa -d .*'                            # 仅显示当前目录下的隐藏文件
alias lt='exa -T'                               # 按修改时间排序
alias lr='exa -r'                               # 反向排序
alias lx='exa -d */'                            # 仅列出目录
alias lk='exa -S'                               # 按文件大小排序
alias lm='exa --git --all --long --header'      # 显示Git信息

## alias设置 - zinit
alias zup='zinit self-update'                   # 更新zinit本身
alias zupall='zinit update'                     # 更新zinit安装的软件包

# oh-my-zsh 设置 取消=注释即可
CASE_SENSITIVE="true"                           # 使用区分大小写的自动补全
HYPHEN_INSENSITIVE="true"                       # 使用不区分连字符的自动补全
zstyle ':omz:update' mode auto                  # 自动更新行为:自动
ENABLE_CORRECTION="true"                        # 启用命令自动更正
HIST_STAMPS="mm/dd/yyyy"                        # 历史记录显示日期
HISTFILE=~/.zsh_history                         # 历史记录文件路径
#DISABLE_MAGIC_FUNCTIONS="true"                 # 如果粘贴URL和其他文本时出现混乱 取消注释
#DISABLE_AUTO_TITLE="true"                      # 禁止自动设置终端标题


# zinit 手动安装代码片段(修改了安装路径)
ZINIT_HOME="$HOME/.zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zinit内置插件
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# zinit light模块
zinit light zsh-users/zsh-completions            # zsh自动补全 其他补充
zinit light zsh-users/zsh-syntax-highlighting    # zsh自动语法高亮
zinit light marlonrichert/zsh-autocomplete       # zsh实时自动补全
#zinit light zsh-users/zsh-autosuggestions       # zsh自动补全

# zinit 加载starship
zinit ice as"command" from"gh-r" \
            atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
            atpull"%atclone" src"init.zsh"
zinit light starship/starship
export STARSHIP_CONFIG=$HOME/.config/my_starship.toml

# zsh实时自动补全设置
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
