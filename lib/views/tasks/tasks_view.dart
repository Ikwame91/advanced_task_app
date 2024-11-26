import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:advanced_taskapp/main.dart';
import 'package:advanced_taskapp/models/task.dart';
import 'package:advanced_taskapp/utils/colors.dart';
import 'package:advanced_taskapp/utils/constants.dart';
import 'package:advanced_taskapp/utils/date_utils.dart';
import 'package:advanced_taskapp/utils/strings.dart';
import 'package:advanced_taskapp/views/tasks/components/date_time_select.dart';
import 'package:advanced_taskapp/views/tasks/components/top_text.dart';
import 'package:advanced_taskapp/views/tasks/widgets/task_view_appbar.dart';
import 'package:advanced_taskapp/views/tasks/widgets/tasktextfield.dart';

class TasksView extends StatefulWidget {
  const TasksView({
    Key? key,
    this.taskControllerForTitle,
    this.descriptiomController,
    required this.task,
    required this.onTaskUpdated,
  }) : super(key: key);
  final TextEditingController? taskControllerForTitle;
  final TextEditingController? descriptiomController;
  final Task? task;
  final Function(Task?) onTaskUpdated;
  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  late TextEditingController taskControllerForTitle;
  late TextEditingController descriptiomController;
  // var title;
  // var subTitle;
  DateTime? time;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    taskControllerForTitle = widget.taskControllerForTitle ??
        TextEditingController(text: widget.task?.title ?? '');
    descriptiomController = widget.descriptiomController ??
        TextEditingController(text: widget.task?.subTitle ?? '');

    // Initialize time and date
    time = widget.task?.createdAtTime ?? DateTime.now();
    date = widget.task?.createdAtDate ?? DateTime.now();
  }

  @override
  void dispose() {
    // Dispose controllers only if they were created locally
    if (widget.taskControllerForTitle == null) taskControllerForTitle.dispose();
    if (widget.descriptiomController == null) descriptiomController.dispose();
    super.dispose();
  }

  /// Show Selected Time as String Format
  String showTime(DateTime? time) {
    return DateTimeUtils.formatTime(time ?? DateTime.now());
  }

  /// Show Selected Date as String Format
  String showDate(DateTime? date) {
    return DateTimeUtils.formatDate(date ?? DateTime.now());
  }

  /// Show Selected Time as DateTime Format
  DateTime showTimeAsDateTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      return time ?? DateTime.now();
    } else {
      return widget.task!.createdAtTime;
    }
  }

  /// Show Selected Date as DateTime Format
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      return date ?? DateTime.now();
    } else {
      return widget.task!.createdAtDate;
    }
  }

  bool isTasklreadyExists() {
    if (taskControllerForTitle.text == null &&
        descriptiomController.text == null) {
      return true;
    } else {
      return false;
    }
  }

  /// If any task already exist app will update it otherwise the app will add a new task
  void isTaskAlreadyExistUpdateTask() {
    if (taskControllerForTitle.text.trim().isNotEmpty &&
        descriptiomController.text.trim().isNotEmpty) {
      if (widget.task != null) {
        // Update existing task
        setState(() {
          widget.task?.title = taskControllerForTitle.text.trim();
          widget.task?.subTitle = descriptiomController.text.trim();
          widget.task?.createdAtDate = date ?? DateTime.now();
          widget.task?.createdAtTime = time ?? DateTime.now();
          widget.task?.save(); // Save changes to Hive
          widget.onTaskUpdated(widget.task);
        });
      } else {
        // Add a new task
        final newTask = Task.create(
          title: taskControllerForTitle.text.trim(),
          subTitle: descriptiomController.text.trim(),
          createdAtDate: date,
          createdAtTime: time,
        );
        BaseWidget.of(context).dataStore.addTask(task: newTask);
        widget.onTaskUpdated(newTask);
      }

      // Clear fields and navigate back
      taskControllerForTitle.clear();
      descriptiomController.clear();
      Navigator.of(context).pop();
    } else {
      emptyFieldsWarning(context);
    }
  }

  dynamic deleteTask() {
    widget.onTaskUpdated(null);
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: const TaskViewAppbar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //toptext
                const TopText(),
                SizedBox(
                  width: double.infinity,
                  height: 535,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title of TextFiled
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(MyString.titleOfTitleTextField,
                            style: textTheme.headlineMedium),
                      ),

                      /// Title TextField
                      TaskTextField(
                        controller: taskControllerForTitle,
                        onChanged: (value) => setState(() {
                          widget.task?.title = value;
                        }),
                        onFieldSubmitted: (value) => setState(() {
                          widget.task?.title = value;
                        }),
                      ),
                      // Task Description TextField
                      TaskTextField(
                        controller: descriptiomController,
                        isForDescription: true,
                        onChanged: (value) => setState(() {
                          widget.task?.subTitle = value;
                        }),
                        onFieldSubmitted: (value) => setState(() {
                          widget.task?.subTitle = value;
                        }),
                      ),
                      DateTimeSelection(
                        title: MyString.timeString,
                        time: showTime(time),
                        onTap: () async {
                          TimeOfDay? selectedTime = await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(time ?? DateTime.now()),
                          );

                          if (selectedTime != null) {
                            // Ensure only the time part changes, and date remains intact
                            setState(() {
                              time = DateTime(
                                date?.year ?? DateTime.now().year,
                                date?.month ?? DateTime.now().month,
                                date?.day ?? DateTime.now().day,
                                selectedTime.hour,
                                selectedTime.minute,
                              );
                            });
                          }
                        },
                      ),

                      DateTimeSelection(
                        title: MyString.dateString,
                        time: showDate(date),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: date ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (selectedDate != null) {
                            // Update both date and time components to maintain consistency
                            setState(() {
                              date = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                time?.hour ?? DateTime.now().hour,
                                time?.minute ?? DateTime.now().minute,
                              );
                            });
                          }
                        },
                      ),

                      Row(
                        mainAxisAlignment: isTasklreadyExists()
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceEvenly,
                        children: [
                          isTasklreadyExists()
                              ? Container()
                              : MaterialButton(
                                  onPressed: () {
                                    deleteTask();
                                    Navigator.pop(context);
                                  },
                                  minWidth: 150,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 50,
                                  child: const Row(
                                    children: [
                                      Icon(CupertinoIcons.trash),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        MyString.deleteTask,
                                        style: TextStyle(
                                            color: MyColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                          MaterialButton(
                            onPressed: () {
                              isTaskAlreadyExistUpdateTask();
                            },
                            minWidth: 150,
                            color: MyColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            height: 50,
                            child: Text(
                              isTasklreadyExists()
                                  ? MyString.addTaskString
                                  : MyString.addTaskString,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
