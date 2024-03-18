import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseminer/utils/screen_routes.dart';
import 'package:firebaseminer/utils/theme/theme_controller.dart';
import 'package:firebaseminer/utils/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

ThemeController controller = Get.put(ThemeController());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    Obx(
      () {
        controller.changeTheme();
        return GetMaterialApp(
          theme: controller.isLight.value?darkTheme:lightTheme,
          debugShowCheckedModeBanner: false,
          routes: screen_routes,
        );
      }
    ),
  );
}