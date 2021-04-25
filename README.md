# GlinkWork App

## Design and document
- https://drive.google.com/drive/folders/1onQCCCM8t8EVufwpWT4C9WyI45Fm0tWz?usp=sharing

## Develop environment

- OS: MacOS
- Flutter channel stable version 1.20.4
- Android Studio 4.0.1
- XCode 12
- Cocopods: https://guides.cocoapods.org/using/getting-started.html

## Config project:
- cd to root project
- change BASE_URL for api endpoint locate at ``lib/src/common/config.dart``

## Build project instructions:
- Get packages with 
``flutter pub get``
- Clean the old build
  ``flutter clean``
- Generate annotation files
  ``flutter pub run build_runner build --delete-conflicting-outputs``
- Build iOS framework
  ``flutter build ios --no-codesign`` 
- Build Android framework
  ``flutter build apk``
- Run app with ``flutter run -d ``  with device id come from ``flutter devices``