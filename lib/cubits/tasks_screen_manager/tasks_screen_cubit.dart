import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/cubits/tasks_screen_manager/tasks_screen_sate.dart';

import '../../consts.dart';

class TasksCubit extends Cubit<TasksStates> {
  TasksCubit() : super(TasksStateInitial());
  int screenIndex = 0;
  List<Map> homeList = [];
  List<Map> doneList = [];
  List<Map> archiveList = [];

  void changeIndexScreen(int x) {
    screenIndex = x;
    emit(IndexChanged());
  }

  Database? database;

  Future<void> createDataBase() async {
    emit(CreateDbLoading());
    database = await openDatabase('todo.db', version: 1,
        onCreate: (Database dataBase, version) async {
      print('data base created');
      await dataBase
          .execute(
              'create table tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, isDone TEXT,time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((e) {
        print('Error during create DataBase: ${e.toString()}');
      });
    }, onOpen: (Database dataBase) async {
      print(dataBase);
      print('data base opened');
    }).then((value) {
      getData(database: value);
      emit(CreateDbSuccess());
      return value;
    }).catchError((e) {
      print('create Database error: ${e.toString()}');
      emit(CreateDbFailure(errorMessage: e.toString()));
    });
  }

  Future insertToDataBase({required String title, required TimeOfDay time, required DateTime date}) async {
    emit(InsertLoading());
    await database?.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status,isDone) VALUES("$title","${date.day}-${date.month}-${date.year}","${time.hour}:${time.minute}","new","false")')
          .then((value) {
        emit(InsertSuccess());
        print('successful insert value: $value');
        getData(database: database!);
      }).catchError((e) {
        emit(InsertFailure(errorMessage: e.toString()));
        print('Error during insert new record: ${e.toString()}');
      });
      return Future(() => null);
    });
  }

  Future getData({required Database database}) async {
    // await deleteDatabase('/data/user/0/com.example.todo/databases/todo.db');
    List<Map> tasksList=[];
    emit(TasksLoading());
    List<Map> x = tasksList;
    tasksList = await database.rawQuery('SELECT * FROM tasks').then((value) {
      print('tasks List: ${value.length}');
      emit(TasksSuccess());
      return value;
    }).catchError((e) {
      print('getDate error: ${e.toString()}');
      emit(TasksFailure(errorMessage: e.toString()));
      return x;
    });
    if(tasksList!=[]){
      doneList= tasksList.where((element) {
        bool x =false;
        if(element['isDone']=='true'){
          x =true;
        }return x;
      }).toList();
      archiveList= tasksList.where((element) {
        bool x =false;
        if(element['status']=='old'){
          x =true;
        }return x;
      }).toList();
      homeList=tasksList.where((element) {
        bool x =false;
        if(element['isDone']=='false'&&element['status']=='new'){
          x=true;
        }
        return x;
      }).toList();
    }
  }

  Future updateTask({required String title, required String time, required String date, required int id}) async {
    await database!.rawUpdate(
        'UPDATE tasks SET title = ?, time = ?,date= ? WHERE id = ?',
        [title, time, date, '$id']).then((value) {
      getData(database: database!);
      emit(UpdateSuccess());
    }).catchError((e) {
      print('update error: ${e.toString()}');
      emit(UpdateFailure(errorMessage: e.toString()));
    });
  }

  Future updateStatus({required String status, required int id,required BuildContext ctx}) async {
    await database!
        .rawUpdate(
            'UPDATE tasks SET status =? WHERE id = ?', [status, '$id'])
        .then((value) async{
          await getData(database: database!);
          emit(UpdateStatusSuccess());
        })
        .catchError((e) {
      showDialog(context: ctx, builder: (ctx){
        return AlertDialog(
          elevation: 5,
          icon: Row(
            mainAxisSize: MainAxisSize.max,
            children: const [
              Icon(Icons.error,color: Colors.red,),
              SizedBox(width: 10,),
              Text('Database ERROR',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
            ],
          ),
          content: TextButton(onPressed: ()=>Navigator.of(ctx).pop(), child: const Text('Close',style: TextStyle(fontSize: 18),)),
        );
      });
          print('update state error: ${e.toString()}');
          emit(UpdateStatusFailure(errorMessage: e.toString()));
    });
  }

  Future updateIsDone({required String isDone, required int id,required BuildContext ctx}) async {
    await database!
        .rawUpdate(
        'UPDATE tasks SET isDone =? WHERE id = ?', [isDone, '$id'])
        .then((value) async{
      await getData(database: database!);
      emit(UpdateIsDoneSuccess());
    }).catchError((e) {
          showDialog(context: ctx, builder: (ctx){
            return dialog(errorMessage: 'Error occur during update',error: e.toString(), ctx: ctx);
          });
      print('isDone error: ${e.toString()}');
      emit(UpdateIsDoneFailure(errorMessage: e.toString()));
    });
  }

  Future delete({required int id,required BuildContext ctx}) async {
    await database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) async{
      print('Item: $id deleted');
      await getData(database: database!);
      emit(DeleteSuccess());}).catchError((e){
      showDialog(context: ctx, builder: (ctx){
        return dialog(errorMessage: 'Error occur during delete',error: e.toString() ,ctx: ctx);
      });
      emit(DeleteFailure(errorMessage: e.toString()));
    });
  }


}
