# hysteria_server.sh
hysteria官网的安装脚本(修改了路径)
[官方安装文档_在这里](https://v2.hysteria.network/zh/docs/getting-started/Installation/)

## installed
**配置文件默认在`/opt/hysteria_server/config.yaml`**
```
installed: /opt/hysteria_server
installed: /opt/hysteria_server/hysteria
installed: /etc/systemd/system/multi-user.target.wants/hysteria-server.service
installed: /etc/systemd/system/multi-user.target.wants/hysteria-server@*.service
```

## Basic Usage
**安装/更新**
```
bash <(curl -fsSL https://raw.githubusercontent.com/1trapbox/1box/main/hysteria/hysteria_server.sh)
```
**卸载**
```
bash <(curl -fsSL https://raw.githubusercontent.com/1trapbox/1box/main/hysteria/hysteria_server.sh)  --remove
```
