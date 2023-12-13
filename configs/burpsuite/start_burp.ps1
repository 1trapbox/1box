# ps1脚本 用于启动burpsuite

# Set the working directory
$workingDirectory = "E:\1trapshell\Burpsuite"
Set-Location -Path $workingDirectory

    pwsh -WindowStyle Hidden -c {
    # Run Java command
    java `
    -XX:+IgnoreUnrecognizedVMOptions `
    --add-opens=java.desktop/javax.swing=ALL-UNNAMED `
    --add-opens=java.base/java.lang=ALL-UNNAMED `
    --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED `
    --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED `
    --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED `
    -javaagent:burpsuitloader-3.7.17-all.jar=loader,hanizfy `
    -jar burpsuite_pro_v2023.11.1.3.jar
}
