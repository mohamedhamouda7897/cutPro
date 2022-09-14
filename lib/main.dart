import 'dart:io';

import 'package:cutpro/shared/network/remote/dio_helper.dart';
import 'package:cutpro/shared/styles/themes.dart';
import 'package:flutter/material.dart';

import 'layouts/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomeLayout(),
      theme: MyThemeData.lightTheme,
      themeMode: ThemeMode.light,
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
