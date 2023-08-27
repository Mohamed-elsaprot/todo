import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_cubit.dart';
import '../../../core/general_widgets/bottom_sheet.dart';

class ShowBottomSheetButton extends StatelessWidget {
  const ShowBottomSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cubit = BlocProvider.of<TasksCubit>(context);
    return FloatingActionButton(
      onPressed: () {
        BottomModalSheet.buildSheet(
          ctx: context,
          size: size,
          function: () async {
            if (BottomModalSheet.formKey.currentState!.validate()) {
              await cubit
                  .insertToDataBase(
                      title: BottomModalSheet.title!,
                      time: BottomModalSheet.timeOfDay,
                      date: BottomModalSheet.dateTime)
                  .then((value) async {
                Navigator.pop(context);
              });
            }
          },
        );
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
