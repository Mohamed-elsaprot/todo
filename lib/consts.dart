import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/archive_screen/archived_tasks_screen.dart';
import 'package:todo/screens/done_screen/done_tasks_screen.dart';
import 'package:todo/screens/tsks_screen/tasks_screen.dart';

  const List<Widget> screens=[
  TasksScreen(),
  DoneTasks(),
  ArchiveTasks()
];

  AlertDialog dialog({required String errorMessage,required String error,required BuildContext ctx}){
    return AlertDialog(
      elevation: 5,
      icon: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(Icons.error,color: Colors.red,),
          const SizedBox(width: 10,),
          Text(errorMessage,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(error,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          TextButton(onPressed: ()=>Navigator.of(ctx).pop(), child: const Text('Close',style: TextStyle(fontSize: 18),)),
        ],
      ),
    );
  }