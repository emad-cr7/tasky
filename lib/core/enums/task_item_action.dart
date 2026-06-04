enum TaskItemAction {
  markAsDone (name: "Done | Un Done"),
  edit(name: "Edit"),
  delete(name: "Delete");
  final String name;

  const TaskItemAction({required this.name});
}
