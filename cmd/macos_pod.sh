cd ..
clear
cd macos || exit
#pod repo update --verbose # 还不行先删除Podfile.lock
pod install --repo-update --verbose