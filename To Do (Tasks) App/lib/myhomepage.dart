import 'package:flutter/material.dart';
import 'package:to_do_list_app/task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'TaskList.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> tasks = [];
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  void toggleCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted!;
    });
  }

  void addTask(String title, String description) {
    setState(() {
      tasks.add(Task(title: title, description: description));
      titlecontroller.clear();
      descriptioncontroller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.roboto(
              fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            if (tasks.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All Tasks',
                  style: GoogleFonts.openSans(
                      fontStyle: FontStyle.normal, fontSize: 17),
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: TaskList(
                tasks: tasks,
                toggleCompletion: toggleCompletion,
                deleteTask: deleteTask,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add a task'),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titlecontroller,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: descriptioncontroller,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (titlecontroller.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Note'),
                              content: const Text('Title cannot be empty'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'))
                              ],
                            );
                          },
                        );
                      } else {
                        addTask(
                            titlecontroller.text, descriptioncontroller.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
