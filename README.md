# 生成 Retrofit 实现代码，包括modle里面的解析类 都会自动生成（需要注意的时候要指定自动生成的文件名）
flutter pub run build_runner build

# 或者监听文件变化自动生成
flutter pub run build_runner watch

# 如果遇到冲突，可以清理后重新生成
flutter pub run build_runner build --delete-conflicting-outputs