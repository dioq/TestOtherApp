#!/bin/sh

# SRCROOT                       当前工程所在的目录
# PRODUCT_NAME                  产品名称
# BUILT_PRODUCTS_DIR            Xcode创建App时 xxx.app 的缓存目录 command + shift + c 可以清空这个目录
# EXPANDED_CODE_SIGN_IDENTITY   当前工程运行时所使用的签名证书

# 待调试 xxx.app, Xcode 里的BundleID 要和 xxx.app/Info.plist里的一致
TARGET_APP_NAME=WeChat.app


TARGET_APP_PATH=${SRCROOT}/${TARGET_APP_NAME} # 需要复制的目标应用
BUILD_APP_PATH=${BUILT_PRODUCTS_DIR}/"${PRODUCT_NAME}.app" # Xcode 运行时会创建的 xxx.app


# 清空 Xcode 创建 App 的缓存目录
rm -rf ${BUILT_PRODUCTS_DIR}/*
# 复制待调试xxx.app到 Xcode缓存目录,并修改名字为当前工程可识别的名字.实现替换xxx.app的目的
cp -rf ${TARGET_APP_PATH} ${BUILD_APP_PATH}
# 删除 Plugins 和 Watch (这两个插件不能用个人证书签名)
rm -rf ${BUILD_APP_PATH}/PlugIns
rm -rf ${BUILD_APP_PATH}/Watch

# 签名
## 签名动态库
/usr/bin/codesign --force --sign "${EXPANDED_CODE_SIGN_IDENTITY}" ${BUILD_APP_PATH}/Frameworks/*.dylib
/usr/bin/codesign --force --sign "${EXPANDED_CODE_SIGN_IDENTITY}" ${BUILD_APP_PATH}/Frameworks/*.framework
## 签名Mach-O可执行文件
exe_bin="${TARGET_APP_NAME%%.*}"
/usr/bin/codesign --force --sign "${EXPANDED_CODE_SIGN_IDENTITY}" ${BUILD_APP_PATH}/${exe_bin}
