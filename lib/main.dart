import 'dart:io';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inexture/firebase_options.dart';
import 'package:inexture/routes/app_pages.dart';

import 'common_widget/app_colors.dart';
import 'common_widget/common_upper_container.dart';
import 'common_widget/global_value.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Global.getToken();
  runApp(MyApp());
  Get.put(WallpaperController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FlutterQuillLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          hoverColor: AppColors.transparent,
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: AppColors.yelloww,
            cursorColor: AppColors.yelloww,
            selectionHandleColor: AppColors.yelloww,
          ),
        ),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
