
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{
  //theme
  void setTheme(bool isTheme) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool('theme', isTheme);
  }

  Future<bool?> getTheme() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? isTheme = shr.getBool('theme');
    return isTheme;
  }
}