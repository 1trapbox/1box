仓库地址 https://github.com/iDvel/rime-ice

## 设置指定应用默认为英文, 以及更改字体
- 小狼毫安装根目录 (程序文件夹) - 修改/覆盖 `weasel.yaml`
- 新增`app_options`, 修改了`style`20-28行, 其他默认.
```
# 路径
C:\Software\Rime\weasel-0.15.0\data\weasel.yaml
```


 ## 更换按键/候选词修改为6
- 小狼毫 (用户配置目录) - 修改/覆盖 `default.yaml`
- `page_size`修改为6, 新增代码第70行 (回车键下面的shit键支持切换大小写)
```
路径
C:\Users\$env:USERNAME\AppData\Roaming\Rime
```

 ## 更换默认为英文标点
- 小狼毫 (用户配置目录) - 修改/覆盖 `rime_ice.schema.yaml`
- `ascii_punct`中英标点设置为0, 开启默认英文标点.
```
路径
C:\Users\$env:USERNAME\AppData\Roaming\Rime
```