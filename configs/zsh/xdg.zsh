# 环境变量 - XDG目录规范
export XDG_CONFIG_HOME="$HOME/.config"          # 用户 特定配置的目录（类似于 /etc）
export XDG_CACHE_HOME="$HOME/.cache"            # 用户 指定的非必要（缓存）数据的写入位置（类似于 /var/cache）
export XDG_DATA_HOME="$HOME/.local/share"       # 用户 特定数据文件的写入位置（类似于 /usr/share）
export XDG_STATE_HOME="$HOME/.local/state"      # 用户 特定状态文件应写入的位置（类似于 /var/lib）
export XDG_DATA_DIRS="/usr/local/share"         # 全局 存储数据文件
export XDG_CONFIG_DIRS="/etc/xdg"               # 全局 默认配置文件
export ZCOMPDUMP="$HOME/.config/zsh/zcompdump"  # zcompdump指定路径
#export ZDOTDIR="$HOME/.config/zsh"             # zsh指定配置文件目录 (放至.zshenv)