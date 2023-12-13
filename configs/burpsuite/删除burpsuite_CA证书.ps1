# 系统CA存储位置
$systemCert = certutil -store Root | find "PortSwigger CA"
# 用户CA存储位置
$userCert = certutil -user -store Root | find "PortSwigger CA"


if ($null -ne $systemCert) {
    # 找到证书，删除并输出成功消息
    certutil -delstore Root "PortSwigger CA"
    Write-Host "成功删除系统存储位置的 PortSwigger CA 证书。"
} else {
    # 未找到证书，输出提示消息
    Write-Host "在系统存储位置未找到 PortSwigger CA 证书。"
}


if ($null -ne $userCert) {
    # 找到证书，删除并输出成功消息
    certutil -user -delstore Root "PortSwigger CA"
    Write-Host "成功删除用户存储位置的 PortSwigger CA 证书。"
} else {
    # 未找到证书，输出提示消息
    Write-Host "在用户存储位置未找到 PortSwigger CA 证书。请手动查找。"
}

Write-Host "脚本执行完成,请按下回车键退出"
Read-Host