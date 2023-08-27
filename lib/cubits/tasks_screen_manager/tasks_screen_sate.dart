abstract class TasksStates{
  const TasksStates();
}
class TasksStateInitial extends TasksStates{}

class IndexChanged extends TasksStates{}

class CreateDbLoading extends TasksStates{}
class CreateDbSuccess extends TasksStates{}
class CreateDbFailure extends TasksStates{
  CreateDbFailure({required this.errorMessage});
  final String errorMessage;
}

class TasksLoading extends TasksStates{}
class TasksSuccess extends TasksStates{}
class TasksFailure extends TasksStates{
  const TasksFailure({required this.errorMessage});
  final String errorMessage;
}


class InsertLoading extends TasksStates{}
class InsertSuccess extends TasksStates{}
class InsertFailure extends TasksStates{
  const InsertFailure({required this.errorMessage});
  final String errorMessage;
}

class UpdateSuccess extends TasksStates{}
class UpdateFailure extends TasksStates{
  const UpdateFailure({required this.errorMessage});
  final String errorMessage;
}

class UpdateStatusSuccess extends TasksStates{}
class UpdateStatusFailure extends TasksStates{
  const UpdateStatusFailure({required this.errorMessage});
  final String errorMessage;
}

class UpdateIsDoneSuccess extends TasksStates{}
class UpdateIsDoneFailure extends TasksStates{
  const UpdateIsDoneFailure({required this.errorMessage});
  final String errorMessage;
}

class DeleteSuccess extends TasksStates{}
class DeleteFailure extends TasksStates{
  const DeleteFailure({required this.errorMessage});
  final String errorMessage;
}