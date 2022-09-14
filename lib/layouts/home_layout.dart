import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:cutpro/layouts/cubit/cubit.dart';
import 'package:cutpro/layouts/drawer.dart';
import 'package:cutpro/shared/styles/colors.dart';
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
            appBar: AppBar(
                centerTitle: false,
                title: const Text('Feed'),
                toolbarHeight: 70,
                actions: const [
                  SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.workspace_premium,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                ]),
            drawer: const AppDrawer(),
            bottomNavigationBar: ConvexAppBar(
              backgroundColor: primaryColor,
              activeColor: SecondaryColor,
              color: Colors.white,
              style: TabStyle.fixedCircle,
              items: const [
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
