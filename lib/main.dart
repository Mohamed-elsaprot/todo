import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_sate.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_cubit.dart';
import 'package:todo/screens/tsks_screen/component/floating_action_button.dart';
import 'consts.dart';
import 'core/general_widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'todo app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.white30,
        ),
        home: BlocProvider(
          create: (context) => TasksCubit()..createDataBase(),
          child: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TasksCubit>(context);
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        return Scaffold(
            appBar: AppBar(
                // backgroundColor: Colors.cyan,
                ),
            body: screens[cubit.screenIndex],
          floatingActionButton: cubit.screenIndex == 0 ? const ShowBottomSheetButton() : null,
          bottomNavigationBar: NavBar(index: cubit.screenIndex),
        );

      },
    );
  }
}
