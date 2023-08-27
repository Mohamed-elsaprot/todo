import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_sate.dart';
import '../../../core/general_widgets/bottom_sheet.dart';
import '../../../cubits/tasks_screen_manager/tasks_screen_cubit.dart';
import '../../../core/custom_widgets/conditional_builder.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TasksCubit>(context);
    return BlocBuilder<TasksCubit, TasksStates>(builder: (context, state) {
      print('List state: $state');
      return Scaffold(
        body: ConditionalList(
          list: cubit.homeList,
        ),
      );
    });
  }
}

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
    required this.id,
    required this.isDone,
  }) : super(key: key);
  final String title, date, time, status;
  final bool isDone;
  final int id;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<TasksCubit>(context);
    Size size = MediaQuery.of(context).size;
    return Slidable(
        startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context)async{
                  await cubit.delete(id: id, ctx: context);
                },
                label: 'delete',
                icon: Icons.delete,
                backgroundColor: Colors.red,
              )
            ]
        ),
        child: ListTile(
      onTap: () async {
        BottomModalSheet.titleController.text = title;
        BottomModalSheet.dateController.text = date;
        BottomModalSheet.timeController.text = time;
        BottomModalSheet.buildSheet(
            ctx: context,
            size: size,
            function: () async {
              cubit
                  .updateTask(
                      title: BottomModalSheet.title,
                      time:
                          '${BottomModalSheet.timeOfDay.hour}:${BottomModalSheet.timeOfDay.minute}',
                      date:
                          '${BottomModalSheet.dateTime.day}-${BottomModalSheet.dateTime.month}-${BottomModalSheet.dateTime.year}',
                      id: id)
                  .then((value) => Navigator.pop(context));
            });
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              bool done = isDone;
              done = !done;
              await cubit.updateIsDone(
                  id: id, isDone: done.toString(), ctx: context);
            },
            icon: Icon(
              Icons.done_all,
              size: 25,
              color: isDone ? Colors.greenAccent : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              String st = status;
              st = st == 'new' ? 'old' : 'new';
              await cubit.updateStatus(id: id, status: st, ctx: context);
            },
            icon: Icon(
              Icons.archive_outlined,
              size: 25,
              color: status == 'new' ? Colors.white : Colors.greenAccent,
            ),
          ),
        ],
      ),
      leading: CircleAvatar(
        radius: 30,
        child: Center(
          child: Text(
            time,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          date,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ));
  }
}
