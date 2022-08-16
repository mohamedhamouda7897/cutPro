import 'package:cutpro/layouts/cubit/states.dart';
import 'package:cutpro/modules/category/category_screen.dart';
import 'package:cutpro/modules/feed/feed_screen.dart';
import 'package:cutpro/modules/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
 
  AppCubit() : super(AppInitialState());


  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  List<Widget> bottomScreens = [
    const CategoryScreen(),
       const FeedScreen(),
    const ProfileScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }
}
