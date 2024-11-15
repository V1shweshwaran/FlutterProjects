import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_app/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(int) toggleCompletion;
  final Function(int) deleteTask;

  TaskList({
    required this.tasks,
    required this.toggleCompletion,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              'Add your tasks',
              style: GoogleFonts.openSans(
                  fontStyle: FontStyle.normal, fontSize: 14),
            ),
          )
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  tileColor: Theme.of(context).colorScheme.onInverseSurface,
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      Checkbox(
                        value: tasks[index].isCompleted,
                        onChanged: (bool? newValue) {
                          toggleCompletion(index);
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Task'),
                                content: Text(
                                    'Are you sure to delete \n"${tasks[index].title}"?'),
                                actions: [
                                  TextButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteTask(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  title: Text(
                    tasks[index].title!,
                    style: tasks[index].isCompleted!
                        ? GoogleFonts.openSans(
                            fontStyle: FontStyle.italic,
                            fontSize: 17,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3.5)
                        : GoogleFonts.openSans(
                            fontStyle: FontStyle.italic, fontSize: 17),
                  ),
                  subtitle: Text(
                    tasks[index].description!,
                    style: tasks[index].isCompleted!
                        ? GoogleFonts.openSans(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3.2)
                        : GoogleFonts.openSans(
                            fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                ),
              );
            },
          );
  }
}
