import 'package:flutter/material.dart';

import '../custom_widgets/custom_textfield.dart';

abstract class BottomModalSheet{
  static TextEditingController titleController = TextEditingController();
  static TextEditingController dateController = TextEditingController();
  static TextEditingController timeController = TextEditingController();
  static GlobalKey<FormState> formKey = GlobalKey();
  static DateTime dateTime = DateTime.now();
  static TimeOfDay timeOfDay = TimeOfDay.now();
  static String title='';

  static buildSheet({
    required ctx,
    required size,
    required Function function
  }) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 20,
                  right: 20,
                  top: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hint: 'Title',
                      textEditingController: titleController,
                      iconData: Icons.title,
                      onChange: (x) {
                        title = x;
                      },
                    ),
                    SizedBox(
                      height: size.height * .04,
                    ),
                    CustomTextField(
                      hint: 'Time',
                      textEditingController: timeController,
                      iconData: Icons.article_outlined,
                      onTap: () {
                        showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          if (value != null) {
                            timeController.text = '${value.hour}:${value.minute}';
                            timeOfDay = value;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * .04,
                    ),
                    CustomTextField(
                      hint: 'Date',
                      iconData: Icons.access_time,
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: dateTime,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030))
                            .then((value) {
                          if (value != null) {
                            dateController.text = '${value.day}-${value.month}-${value.year}';
                            dateTime = value;
                          }
                        });
                      },
                      textEditingController: dateController,
                    ),
                    SizedBox(
                      height: size.height * .04,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () async{
                          await function();
                      },
                      label: const Text('New Task'),
                    )
                  ],
                ),
              ),
            ),
          );
        }).whenComplete(() {
          titleController=TextEditingController();
          dateController=TextEditingController();
          timeController=TextEditingController();
    });
  }
}