import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const onboardingCompleteKey = 'onboardingComplete';
  static const lastDateTimeKey = 'lastDateTime';

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  Future<void> deleteOnboardingComplete() async {
    await sharedPreferences.remove(onboardingCompleteKey);
  }

  Future<void> setLastDateTime(DateTime dateTime) async {
    await sharedPreferences.setString(lastDateTimeKey, dateTime.toString());
  }

  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;

  DateTime getLastDateTime() {
    final String dateTimeString = sharedPreferences.getString(lastDateTimeKey);
    if (dateTimeString != null) {
      final DateTime parsed = DateTime.parse(dateTimeString);
      return parsed;
    } else {
      setLastDateTime(DateTime.now());
      return DateTime.now();
    }
  }
}
