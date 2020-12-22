
rm lib/buildTime/flutter_version.dart
echo "Building flutter_version.dart"
echo "const Map<String,String> version = " >> lib/buildTime/flutter_version.dart
flutter --version --machine >> lib/buildTime/flutter_version.dart
echo ";" >> lib/buildTime/flutter_version.dart
# echo 'const String appVersion = "1.1.2 build 7";' >> lib/buildTime/flutter_version.dart
printf 'const String appVersion = "' >> lib/buildTime/flutter_version.dart
printf '%s' "$(grep 'version:' pubspec.yaml)" >> lib/buildTime/flutter_version.dart
printf '";' >> lib/buildTime/flutter_version.dart

rm lib/buildTime/flutter_date.dart
echo "Building flutter_date.dart"
printf "const String buildDate  = \"" >> lib/buildTime/flutter_date.dart
printf '%s' "$(date)" >> lib/buildTime/flutter_date.dart
printf  "\";" >> lib/buildTime/flutter_date.dart
echo "Continuing flutter build"


#############
## Testing ##
#############

echo "building web version"
# flutter build web -t lib/websiteMain.dart --release
# flutter build web --profile --dart-define=Dart2jsOptimization=O0
flutter build web --no-sound-null-safety --profile --dart-define=Dart2jsOptimization=O0
echo "moving built web version to public folder"
cp -fr ./build/web/* ./public/
cp -fr ./assets/* ./public/ 

firebase deploy --only hosting
# cd websiteTesting
# echo "pushing new version to github"
# git add .
# now=$(printf '%s' "$(date)")
# git commit -m "AutoCommit webTesting $now"
# git push
# cd ..
# echo "new version pushed to github."
# flutter analyze
# flutter test  # <-- unit test
# # flutter drive --target=test_driver/app.dart  # <-- U/I test
# flutter build ios --release #-t lib/main.dart --release --analyze-size  # <-- build 


# 1. doesn't stop when there's an issue
# 2. doesn't upload to app store
