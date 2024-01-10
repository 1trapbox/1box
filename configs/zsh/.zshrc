## .zshrc
## 更新时间: 2024-1-10

# 环境变量
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"           # zsh指定配置文件目录
export ZSH="$XDG_DATA_HOME/oh-my-zsh"           # ohmyzsh安装路径
# 环境变量 - XDG目录规范
export XDG_CONFIG_HOME="$HOME/.config"          # 用户 特定配置的目录（类似于 /etc）
export XDG_CACHE_HOME="$HOME/.cache"            # 用户 指定的非必要（缓存）数据的写入位置（类似于 /var/cache）
export XDG_DATA_HOME="$HOME/.local/share"       # 用户 特定数据文件的写入位置（类似于 /usr/share）
export XDG_STATE_HOME="$HOME/.local/state"      # 用户 特定状态文件应写入的位置（类似于 /var/lib）
export XDG_DATA_DIRS="/usr/local/share"         # 全局 存储数据文件
export XDG_CONFIG_DIRS="/etc/xdg"               # 全局 默认配置文件

# alias
source $XDG_CONFIG_HOME/zsh/alias.zsh           # alias路径
# oh-my-zsh //设置 取消=注释即可
CASE_SENSITIVE="true"                           # 使用区分大小写的自动补全
HYPHEN_INSENSITIVE="true"                       # 使用不区分连字符的自动补全
zstyle ':omz:update' mode auto                  # 自动更新行为:自动
ENABLE_CORRECTION="true"                        # 启用命令自动更正
#HIST_STAMPS="mm/dd/yyyy"                       # 历史记录显示日期
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
zinit light zdharma-continuum/zinit-annex-binary-symlink        # 🌟 zinit 附件二进制符号链接
zinit load asdf-vm/asdf                                         # asdf版本管理器

# asdf 安装的一些环境变量


# 🌟 by @zinit-annex-binary-symlink
zinit from"gh-r" lbin"!eza" for @eza-community/eza              # 维护更勤快的exa
zinit from"gh-r" lbin"!bat" for @sharkdp/bat                    # 替代cat
zinit from"gh-r" lbin"!rg" for @BurntSushi/ripgrep              # rg
zinit from"gh-r" lbin"!fd" for @sharkdp/fd                      # fd
zinit from"gh-r" lbin"!nvim" for @neovim/neovim                 # 使用nvim
zinit from"gh-r" lbin"!fzf" for junegunn/fzf                    # fzf
zinit from"gh-r" lbin"!glow" for charmbracelet/glow             # 在 CLI 上渲染 Markdown
zinit from"gh-r" lbin"!httpx" for projectdiscovery/httpx        # 快速且多功能的HTTP工具包
# ---------------------------------------------------------------

# 🌟 by @zinit-annex-binary-symlink 带参数的
# ---------------------------------------------------------------
zinit from"gh-r" lbin"!navi" for @denisidoro/navi               # navi 备忘录
eval "$(navi widget zsh)"                                       # shell小部件
# ---------------------------------------------------------------
zinit from"gh-r" lbin"!atuin" for @atuinsh/atuin                # atuin/shell的云同步历史记录
eval "$(atuin init zsh)"                                        # atuin zsh小部件
#bindkey '^r' _atuin_search_widget                              # atuin ctrl+r 快捷键
# ---------------------------------------------------------------
zinit from"gh-r" lbin"!starship" for @starship/starship         # starship
eval "$(starship init zsh)"                                     # starship 导入zsh
export STARSHIP_CONFIG=$HOME/.config/starship/my_starship.toml  # starship 配置文件
# ---------------------------------------------------------------

# ice
zinit ice as"command" pick"xdg-ninja.sh"                        # xdg忍者 检查 $HOME 中是否有不需要的文件和目录
zinit load b3nj5m1n/xdg-ninja                                   # xdg忍者
alias xdgnj=xdg-ninja.sh                                        # xdg忍者 lias
# ---------------------------------------------------------------

# light
zinit light Aloxaf/fzf-tab                                      # fzf
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                                              # 设置列表颜色以启用文件名着色
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'                       # 设置列表颜色以启用文件名着色
zstyle ':completion:*:descriptions' format '[%d]'                                                   # 设置描述格式以启用群组支持
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'      # 显示 systemd 单元状态
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'                                                     # 空格确认
zstyle ':fzf-tab:*' switch-group F1 F2                                                              # F1 F2左右切换数组
#zstyle ':fzf-tab:complete:*:options' fzf-preview

# ez light
zinit light zdharma-continuum/fast-syntax-highlighting          # zinit 语法高亮
zinit light zsh-users/zsh-completions                           # zsh自动补全 其他补充
zinit light jeffreytse/zsh-vi-mode                              # zsh更好的vi(vim)模式插件
zinit light MichaelAquilina/zsh-you-should-use                  # zsh 你应该使用alias
#zinit light zsh-users/zsh-autosuggestions                      # zsh自动补全
# ---------------------------------------------------------------