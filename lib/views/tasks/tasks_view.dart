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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksView extends StatefulWidget {
  const TasksView({
    super.key,
    required this.taskControllerForTitle,
    required this.descriptiomController,
    required this.task,
  });
  final TextEditingController? taskControllerForTitle;
  final TextEditingController? descriptiomController;
  final Task? task;
  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    time = widget.task?.createdAtTime ?? DateTime.now();
    date = widget.task?.createdAtDate ?? DateTime.now();
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
    if (widget.taskControllerForTitle?.text == null &&
        widget.descriptiomController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  bool doesTaskExist() {
    return widget.taskControllerForTitle?.text != null &&
        widget.descriptiomController?.text != null;
  }

  /// If any task already exist app will update it otherwise the app will add a new task
  void isTaskAlreadyExistUpdateTask() {
    if (doesTaskExist()) {
      try {
        widget.task?.title = title ?? widget.task!.title;
        widget.task?.subTitle = subTitle ?? widget.task!.subTitle;
        widget.task?.createdAtDate = date ?? widget.task!.createdAtDate;
        widget.task?.createdAtTime = time ?? widget.task!.createdAtTime;

        widget.task?.save(); // Ensure changes are saved to Hive

        widget.taskControllerForTitle?.clear();
        widget.descriptiomController?.clear();

        Navigator.of(context).pop(); // Navigate back
      } catch (error) {
        nothingEnterOnUpdateTaskMode(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = Task.create(
          title: title!,
          createdAtTime: time ?? DateTime.now(),
          createdAtDate: date ?? DateTime.now(),
          subTitle: subTitle!,
        );

        BaseWidget.of(context).dataStore.addTask(task: task);

        widget.taskControllerForTitle?.clear();
        widget.descriptiomController?.clear();

        Navigator.of(context).pop();
      } else {
        emptyFieldsWarning(context);
      }
    }
  }

  dynamic deleteTask() {
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
                        controller: widget.taskControllerForTitle ??
                            TextEditingController(),
                        onFieldSubmitted: (String inputTitle) {
                          title = inputTitle;
                        },
                        onChanged: (String inputTitle) {
                          title = inputTitle;
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      /// Note TextField
                      TaskTextField(
                        controller: widget.descriptiomController ??
                            TextEditingController(),
                        isForDescription: true,
                        onFieldSubmitted: (String inputSubTitle) {
                          subTitle = inputSubTitle;
                        },
                        onChanged: (String inputSubTitle) {
                          subTitle = inputSubTitle;
                        },
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
                      // DateTimeSelection(
                      //     title: MyString.dateString,
                      //     time: showDate(date),
                      //     onTap: () async {
                      //       DateTime? selectedDate = await showDatePicker(
                      //         context: context,
                      //         initialDate: date ?? DateTime.now(),
                      //         firstDate: DateTime(2000),
                      //         lastDate: DateTime(2100),
                      //       );
                      //       if (selectedDate != null) {
                      //         setState(() {
                      //           date = DateTime(
                      //             selectedDate.year,
                      //             selectedDate.month,
                      //             selectedDate.day,
                      //             time?.hour ?? DateTime.now().hour,
                      //             time?.minute ?? DateTime.now().minute,
                      //           );
                      //         });
                      //       }
                      //     }),

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
