import 'package:flutter/material.dart';
import 'package:test_flutter/model/todo.dart';

class ToDoItem extends StatelessWidget {
  ToDoItem({required this.todo, required this.onCheckAction, required this.onDeleteAction}) : super(key: ObjectKey(todo));

  final ToDo todo;
  final void Function(ToDo aToDo) onCheckAction;
  final void Function(ToDo aToDo) onDeleteAction;

  TextStyle? _textStyleBasedOnChecked(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () { onCheckAction(todo); },
      leading: Checkbox(
        checkColor: Colors.deepOrangeAccent,
        activeColor: Colors.greenAccent,
        value: todo.isCompleted,
        onChanged: (value){ onCheckAction(todo); },
      ),
      title: Row(
        children: <Widget>[
          Expanded(child: Text(todo.content, style: _textStyleBasedOnChecked(todo.isCompleted),)),
          IconButton(onPressed: (){ onDeleteAction(todo); },icon: const Icon(Icons.delete), alignment: Alignment.centerRight,)
        ],
      ),
    );
  }
}