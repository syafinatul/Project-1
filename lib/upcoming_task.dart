import 'package:flutter/material.dart';

class Task {
  final String name;
  final DateTime dueDate;
  bool isDone;

  Task({
    required this.name,
    required this.dueDate,
    this.isDone = false,
  });
}

class UpcomingTaskScreen extends StatefulWidget {
  @override
  _UpcomingTaskScreenState createState() => _UpcomingTaskScreenState();
}

class _UpcomingTaskScreenState extends State<UpcomingTaskScreen> {
  List<Task> tasks = [
    Task(name: 'Task 1', dueDate: DateTime.now().add(Duration(days: 1))),
    Task(name: 'Task 2', dueDate: DateTime.now().add(Duration(days: 2))),
    Task(name: 'Task 3', dueDate: DateTime.now().add(Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do-Task'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 193, 126, 133),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/add.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                setState(() {
                  tasks.removeAt(index);
                });
              },
              child: Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(
                    tasks[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: tasks[index].isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    'Due Date: ${tasks[index].dueDate.toString().split(' ')[0]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: tasks[index].isDone
                            ? Icon(Icons.check_box_outlined, color: Colors.blue)
                            : Icon(Icons.square_outlined, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            tasks[index].isDone = !tasks[index].isDone;
                          });
                          if (tasks[index].isDone) {
                            Future.delayed(Duration(milliseconds: 400), () {
                              setState(() {
                                if (tasks[index].isDone) {
                                  tasks.removeAt(index);
                                }
                              });
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddTaskScreen(context);
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 218, 84, 128),
      ),
    );
  }

  void _navigateToAddTaskScreen(BuildContext context) async {
    final Task? newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
  }
}

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 193, 126, 133),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/list.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 95, 64, 53),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      hintText: 'Enter task name',
                      labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 95, 64, 53),
                      ),
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 95, 64, 53),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0), // Adjust the padding here
                    ),
                    style: TextStyle(
                      color: const Color.fromARGB(255, 95, 64, 53),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.brown,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _dueDateController,
                    decoration: InputDecoration(
                      labelText: 'Due Date',
                      hintText: 'Select due date',
                      labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 95, 64, 53),
                      ),
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 95, 64, 53),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today,
                            color: const Color.fromARGB(255, 95, 64, 53)),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2028),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Color.fromARGB(255, 193, 126, 133),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDate != null) {
                            _dueDateController.text =
                                pickedDate.toString().split(' ')[0];
                          }
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_taskController.text.isNotEmpty &&
                        _dueDateController.text.isNotEmpty) {
                      DateTime selectedDate =
                          DateTime.parse(_dueDateController.text);
                      Task newTask = Task(
                          name: _taskController.text, dueDate: selectedDate);
                      Navigator.pop(context, newTask);
                    }
                  },
                  child: Text(
                    'Add Task',
                    textAlign: TextAlign.right,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 193, 126, 133),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
