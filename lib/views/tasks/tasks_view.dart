import 'package:advanced_taskapp/main.dart';
import 'package:advanced_taskapp/models/task.dart';
import 'package:advanced_taskapp/utils/colors.dart';
import 'package:advanced_taskapp/utils/constants.dart';
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
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now());
      } else {
        return DateFormat('hh:mm a').format(time);
      }
    } else {
      // If task's time exists, format and return it
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  /// Show Selected Time as DateTime Format
  DateTime showTimeAsDateTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      return time ?? DateTime.now();
    } else {
      return widget.task!.createdAtTime;
    }
  }

  /// Show Selected Date as String Format
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now());
      } else {
        return DateFormat.yMMMEd().format(date);
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate);
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

  // bool isTasklreadyExists() {
  //   if (widget.taskControllerForTitle?.text == null &&
  //       widget.descriptiomController?.text == null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  /// If any task already exist app will update it otherwise the app will add a new task
  dynamic isTaskAlreadyExistUpdateTask() {
    if (widget.taskControllerForTitle?.text != null &&
        widget.descriptiomController?.text != null) {
      try {
        // Update existing task
        widget.task?.title = title ?? widget.task!.title;
        widget.task?.subTitle = subTitle ?? widget.task!.subTitle;
        widget.task?.createdAtDate = date ?? widget.task!.createdAtDate;
        widget.task?.createdAtTime = time ?? widget.task!.createdAtTime;

        widget.task?.save();

        widget.taskControllerForTitle?.clear();
        widget.descriptiomController?.clear();

        Navigator.of(context).pop();
      } catch (error) {
        nothingEnterOnUpdateTaskMode(context);
      }
    } else {
      // Create a new task
      if (title != null && subTitle != null) {
        var task = Task.create(
          title: title!,
          createdAtTime: time,
          createdAtDate: date,
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
                          TimeOfDay initialTime =
                              TimeOfDay.fromDateTime(showTimeAsDateTime(time));

                          TimeOfDay? selectedTime =
                              await showModalBottomSheet<TimeOfDay>(
                            context: context,
                            builder: (_) => SizedBox(
                              height: 400,
                              child: TimePickerDialog(initialTime: initialTime),
                            ),
                          );

                          if (selectedTime != null) {
                            setState(() {
                              if (widget.task?.createdAtTime == null) {
                                time = time = DateTime(
                                  date?.year ??
                                      DateTime.now()
                                          .year, // Use the selected date if available
                                  date?.month ?? DateTime.now().month,
                                  date?.day ?? DateTime.now().day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                              } else {
                                widget.task!.createdAtTime = DateTime(
                                  date?.year ?? widget.task!.createdAtDate.year,
                                  date?.month ??
                                      widget.task!.createdAtDate.month,
                                  date?.day ?? widget.task!.createdAtDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                              }
                            });
                          }

                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),

                      DateTimeSelection(
                        isTime: true,
                        title: MyString.dateString,
                        time: showDate(date),
                        onTap: () async {
                          DateTime initialDate = showDateAsDateTime(date);

                          DateTime? selectedDate =
                              await showModalBottomSheet<DateTime>(
                            context: context,
                            builder: (_) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                height: 400,
                                child: Column(
                                  children: [
                                    const Text(
                                      "Pick a Date",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Expanded(
                                      child: CalendarDatePicker(
                                        initialDate: initialDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        onDateChanged: (selectedDate) {
                                          Navigator.pop(
                                            context,
                                            selectedDate,
                                          ); // Return selected date
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                          if (selectedDate != null) {
                            setState(() {
                              if (widget.task?.createdAtDate == null) {
                                date = selectedDate;
                              } else {
                                widget.task!.createdAtDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  widget.task!.createdAtTime.hour,
                                  widget.task!.createdAtTime.minute,
                                );
                              }
                            });
                          }

                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),

                      Row(
                        mainAxisAlignment:
                            //     ? MainAxisAlignment.center
                            MainAxisAlignment.spaceEvenly,
                        children: [
                          // isTasklreadyExists()

                          MaterialButton(
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
                                  style:
                                      TextStyle(color: MyColors.primaryColor),
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
                              //              isTasklreadyExists()
                              // ? MyString.addTaskString
                              MyString.addTaskString,
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
