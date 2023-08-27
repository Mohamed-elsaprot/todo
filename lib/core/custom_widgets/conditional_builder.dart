import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../screens/tsks_screen/component/tasks_list.dart';
import 'no_tasks_widget.dart';

class ConditionalList extends StatelessWidget {
  const ConditionalList({Key? key, required this.list}) : super(key: key);
  final List<Map>list;
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (BuildContext context) => ListView.separated(
          padding: const EdgeInsets.only(top: 15),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => TaskListTile(
            time: list[index]['time'],
            title: list[index]['title'],
            status: list[index]['status'],
            date: list[index]['date'],
            isDone: list[index]['isDone']=='false'?false:true,
            id: list[index]['id'],
          ),
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          itemCount: list.length),
      fallback: (BuildContext context) => const NoTasksWidget(),
    );
  }
}
