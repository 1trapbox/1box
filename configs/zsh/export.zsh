# zsh shell
# 各程序的 export shell环境变量
# 2024-01-19

# @starship
eval "$(starship init zsh)"                                     # starship 导入zsh
export STARSHIP_CONFIG=$HOME/.config/starship/my_starship.toml  # starship 配置文件

# @fzf
export FZF_DEFAULT_COMMAND='fd --type f -u'
export FZF_DEFAULT_OPTS='--preview "bat --color=always --style=numbers,header,rule,snip --line-range=1: {}"'

# @navi
eval "$(navi widget zsh)"                                       # shell小部件

# @atuin
eval "$(atuin init zsh)"                                        # atuin zsh小部件
export ATUIN_CONFIG_DIR=$XDG_CONFIG_HOME/atuin
#bindkey '^r' _atuin_search_widget                              # atuin ctrl+r 快捷键

# @BAT
export BAT_THEME="TwoDark"                                      # bat主题

# @vivid
export LS_COLORS="$(vivid generate snazzy)"                     # LS_COLORS 各种颜色支持

# @asdf asdf/env导入