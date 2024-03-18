
import 'package:firebaseminer/utils/theme/shared_helper.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isLight = false.obs;

  //theme
  void changeTheme() async {
    SharedHelper shr = SharedHelper();
    bool? isTheme = await shr.getTheme();
    isLight.value = isTheme ?? false;
  }
}