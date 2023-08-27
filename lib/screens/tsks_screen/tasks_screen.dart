import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_cubit.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_sate.dart';

import 'component/tasks_list.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TasksCubit>(context);
    return BlocBuilder<TasksCubit, TasksStates>(builder: (context, state) {
      if (state is TasksLoading ||
          state is CreateDbLoading ||
          state is InsertLoading) {
        print('state:$state');
        return const Center(child: CircularProgressIndicator());
      } else if (state is TasksFailure) {
        print('state:$state');
        return Center(
          child: Text(
            state.errorMessage,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        );
      } else if (state is InsertFailure) {
        print('state:$state');
        Future.delayed(const Duration(seconds: 2), () {
          cubit.getData(database: cubit.database!);
        });
        return Center(
          child: Text(state.errorMessage),
        );
      } else if (state is TasksFailure) {
        print('state:$state');
        return Center(
          child: Text(state.errorMessage),
        );
      } else if (state is UpdateFailure) {
        Future.delayed(const Duration(seconds: 2),
            () => cubit.getData(database: cubit.database!));
        print(state.errorMessage);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 30,),
              Text(
                'Something Wrong in Database',
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),
              )
            ],
          ),
        );
      } else {
        print('state:$state');
        return const TasksList();
      }
    });
  }
}
