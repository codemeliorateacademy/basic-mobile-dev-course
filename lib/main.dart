import 'package:flutter/material.dart';
import 'package:test_flutter/model/todo.dart';
import 'package:test_flutter/ui/todo_item.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const ToDoList(title: 'To-Do List'),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key, required this.title});

  final String title;

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<ToDo> _listOfToDoNotes = <ToDo>[];
  final TextEditingController _textEditingController = TextEditingController();

  void _addNewToDoItem(String noteContent) {
    setState(() {
      _listOfToDoNotes.add(ToDo(content: noteContent, isCompleted: false));
      _textEditingController.clear();
    });
  }

  void _onToDoCheckAction(ToDo changedToDo) {
    setState(() {
      changedToDo.isCompleted = !changedToDo.isCompleted;
    });
  }

  void _onToDoDeleteAction(ToDo todoToDelete) {
    setState(() {
      _listOfToDoNotes.removeWhere((element) => element.content == todoToDelete.content);
    });
  }

  Future<void> _showAddItemPopup() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Create a New To-Do Note"),
            content: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: "Enter your notes here"),
              autofocus: true,
            ),
            actions: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addNewToDoItem(_textEditingController.text);
                },
                child: const Text('Add'),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children:
                _listOfToDoNotes.map((ToDo aToDo) {
                  return (
                    ToDoItem(
                        todo: aToDo,
                        onCheckAction: _onToDoCheckAction,
                        onDeleteAction: _onToDoDeleteAction,
                    )
                  );
                }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemPopup(),
        tooltip: 'Add New To-Do',
        child: const Icon(Icons.add),
      ),
    );
  }
}
