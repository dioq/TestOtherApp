# TestOtherApp
Xcode 测试或调试 第三方 app

## 原理
Xcode 运行时会在 Mac 系统的缓存文件夹(BUILT_PRODUCTS_DIR)里 创建 xxx.app,然后把 xxx.app 安装到手机上去,Xcode本身是可以调试这个xxx.app的.
如果想要让 Xcode 调试第三方app,需要在Xcode运行前 把Xcode创建的 xxx.app 替换成第三方 app.
而 Xcode 本身是可以通过 Run Script 运行 shell 脚本的,把替换 xxx.app 的功能写在这个 shell脚本里就可以实现调试第三方app的作用

## 使用
### 步骤1
获取待调试ipa包,解压后把 Target.app 目录放在当前工程下,与MyScript.sh在同一个目录
### 步骤2
设置MyScript.sh 里待调试的 app名, TARGET_APP_NAME=Target.app
### 步骤3
Xcode 里设置BundleID 和 Target.app/Info.plist里的BundleID一致

