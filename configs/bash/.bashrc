# 环境变量 - XDG目录规范
export XDG_CONFIG_HOME="$HOME/.config"          # 用户 特定配置的目录（类似于 /etc）
export XDG_CACHE_HOME="$HOME/.cache"            # 用户 指定的非必要（缓存）数据的写入位置（类似于 /var/cache）
export XDG_DATA_HOME="$HOME/.local/share"       # 用户 特定数据文件的写入位置（类似于 /usr/share）
export XDG_STATE_HOME="$HOME/.local/state"      # 用户 特定状态文件应写入的位置（类似于 /var/lib）
export XDG_DATA_DIRS="/usr/local/share"         # 全局 存储数据文件
export XDG_CONFIG_DIRS="/etc/xdg"               # 全局 默认配置文件

# Path to your oh-my-bash installation.
export OSH="$XDG_DATA_HOME/oh-my-bash"

# 历史记录保存路径
export HISTFILE=$XDG_CONFIG_HOME/bash/history

# 主题
OSH_THEME="font"
# 取消注释以下行以使用区分大小写的完成
# OMB_CASE_SENSITIVE="true"
# 取消注释以下行以使用不区分连字符的补全
# OMB_HYPHEN_SENSITIVE="false"
# 自动更新检查
DISABLE_AUTO_UPDATE="true"
# 取消注释以下行以启用命令自动更正
ENABLE_CORRECTION="true"
# 取消注释以下行以在等待完成时显示红点
# COMPLETION_WAITING_DOTS="true"
# 历史记录文件格式
#HIST_STAMPS='yyyy-mm-dd'
# 您想使用 $OSH/custom 之外的其他自定义文件夹吗
# OSH_CUSTOM=/path/to/new-custom-folder
# 要禁止 oh-my-bash 使用 "sudo"，请将 # 此变量设置为 "false"
OMB_USE_SUDO=true

# 自动补全
completions=(
    system
    composer
    defaults
)

# alias
#aliases=(
#  general
#)

# 插件
#plugins=(
#  git
#  bashmarks
#)

source "$OSH"/oh-my-bash.sh"

# You may need to manually set your language environment
#export LANG=en_US.UTF-8
#export LC_ALL=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"