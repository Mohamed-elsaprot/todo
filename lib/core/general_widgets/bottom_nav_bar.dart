import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_cubit.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key,required this.index}) : super(key: key);
  int index;
  @override
  Widget build(BuildContext context) {
    var cubit= BlocProvider.of<TasksCubit>(context);
    return GNav(
      backgroundColor: Colors.blueGrey,
      color: Colors.white,
      activeColor: Colors.white,
      tabBackgroundColor: Colors.black26,
      onTabChange: (x) => cubit.changeIndexScreen(x),
      selectedIndex: index,
      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      padding: const EdgeInsets.all(10),
      gap: 15,
      iconSize: 30,
      rippleColor: Colors.white30,
      tabMargin: const EdgeInsets.all(10),
      tabs: [
        GButton(icon: Icons.home, text: 'Home', borderRadius: BorderRadius.circular(20),),
        GButton(icon: Icons.task, text: 'Done',borderRadius: BorderRadius.circular(20)),
        GButton(icon: Icons.archive_outlined, text: 'Archive',borderRadius: BorderRadius.circular(20),),
      ],
    );
  }
}
