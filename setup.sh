#!/bin/bash#

flutter_clean() {
  rm -rf .packages pubspec.lock .flutter-plugins .flutter-plugins-dependencies;
  flutter clean;
  flutter pub get;
  flutter pub upgrade;
}

flutter_generate() {
  flutter pub run build_runner build;
}

flutter_generate_delete_conflicting() {
  flutter pub run build_runner build --delete-conflicting-outputs;
}

build_iOS() {
  pod repo update;
  rm ios/Podfile.lock;
  pod install --project-directory=ios;
  flutter build ios --no-codesign;
}

deploy_ios_firebase() {
  flutter_clean;
  flutter_generate_delete_conflicting;
  build_iOS;
  fastlane ios deploy_firebase;
}

deploy_android_firebase() {
  flutter_clean;
  flutter_generate_delete_conflicting;
  flutter build apk;
  fastlane android deploy_firebase;
}

echo "select the option to build ************"
echo "  1) android"
echo "  2) ios"
echo "  3) run build_runner"
echo "  4) run build_runner with delete conflicting"
echo "  5) generate translations"
echo "  6) watch build_runner"
echo "  7) deploy android firebase"
echo "  8) deploy ios firebase"

read n
case $n in
  1) echo "android is building...";
     flutter_clean;
     flutter_generate_delete_conflicting;
     flutter build apk;
     echo "android build finished";;
  2) echo "ios is building...";
     flutter_clean;
     flutter_generate_delete_conflicting;
     build_iOS;
     echo "ios build finished";;
  3) echo "starting build_runner...";
     flutter_generate;
     echo "build_runner finished";;
  4) echo "generating...";
     flutter_generate_delete_conflicting;
     echo "build_runner finished";;
  5) get generate locales assets/locales;;
  6) flutter pub get;
     flutter packages pub run build_runner watch;;
  7) deploy_android_firebase;;
  8) deploy_ios_firebase;;
esac