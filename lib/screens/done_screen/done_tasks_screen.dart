import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_sate.dart';
import '../../../cubits/tasks_screen_manager/tasks_screen_cubit.dart';
import '../../core/custom_widgets/conditional_builder.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TasksCubit>(context);
    return BlocBuilder<TasksCubit, TasksStates>(builder: (context, state) {
      print('List state: $state');
      return Scaffold(
        body: ConditionalList(list: cubit.doneList,),
      );
    });
  }
}

