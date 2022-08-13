import 'dart:io';

import 'package:cutpro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';

import 'layouts/home_layout.dart';
import 'modules/home_screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
