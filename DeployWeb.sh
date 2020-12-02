
rm lib/buildTime/flutterVersion.dart
echo "Building flutterVersion.dart"
echo "const Map<String,String> version = " >> lib/buildTime/flutterVersion.dart
flutter --version --machine >> lib/buildTime/flutterVersion.dart
echo ";" >> lib/buildTime/flutterVersion.dart
# echo 'const String appVersion = "1.1.2 build 7";' >> lib/buildTime/flutterVersion.dart
printf 'const String appVersion = "' >> lib/buildTime/flutterVersion.dart
printf '%s' "$(grep 'version:' pubspec.yaml)" >> lib/buildTime/flutterVersion.dart
printf '";' >> lib/buildTime/flutterVersion.dart

rm lib/buildTime/flutterDate.dart
echo "Building flutterdate.dart"
printf "const String buildDate  = \"" >> lib/buildTime/flutterDate.dart
printf '%s' "$(date)" >> lib/buildTime/flutterDate.dart
printf  "\";" >> lib/buildTime/flutterDate.dart
echo "Continuing flutter build"


#############
## Testing ##
#############

echo "building web version"
# flutter build web -t lib/websiteMain.dart --release
flutter build web --profile --dart-define=Dart2jsOptimization=O0
echo "moving built web version to websiteTesting"
cp -fr ./build/web/* ./websiteTesting/
cp -fr ./assets/* ./websiteTesting/ 
cd websiteTesting
echo "pushing new version to github"
git add .
now=$(printf '%s' "$(date)")
git commit -m "AutoCommit webTesting $now"
git push
cd ..
echo "new version pushed to github."
flutter analyze
flutter test  # <-- unit test
# flutter drive --target=test_driver/app.dart  # <-- U/I test
flutter build ios --release #-t lib/main.dart --release --analyze-size  # <-- build 


# 1. doesn't stop when there's an issue
# 2. doesn't upload to app store
