import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:cutpro/layouts/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: ConvexAppBar(
              style: TabStyle.fixedCircle,
              items: [
                TabItem(icon: Icons.category_outlined, title: 'Categories'),
                TabItem(
                    icon: Icons.local_fire_department_outlined, title: 'Feed'),
                TabItem(icon: Icons.person_outline, title: 'Profile'),
              ],
              initialActiveIndex: cubit.currentIndex, //optional, default as 0
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
