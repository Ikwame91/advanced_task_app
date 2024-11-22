import 'package:advanced_taskapp/utils/colors.dart';
import 'package:advanced_taskapp/utils/strings.dart';
import 'package:advanced_taskapp/views/tasks/components/date_time_select.dart';
import 'package:advanced_taskapp/views/tasks/components/top_text.dart';
import 'package:advanced_taskapp/views/tasks/widgets/task_view_appbar.dart';
import 'package:advanced_taskapp/views/tasks/widgets/tasktextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final TextEditingController taskControllerForTitle = TextEditingController();
  final TextEditingController descriptiomController = TextEditingController();
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
                      TaskTextField(controller: taskControllerForTitle),

                      const SizedBox(
                        height: 10,
                      ),

                      /// Note TextField
                      TaskTextField(
                        controller: descriptiomController,
                        isForDescription: true,
                      ),

                      DateTimeSelection(
                        title: MyString.timeString,
                        onTap: () async {
                          TimeOfDay initialTime = TimeOfDay.now();

                          TimeOfDay? selectedTime = await showModalBottomSheet(
                            context: context,
                            builder: (_) => SizedBox(
                              height: 220,
                              child: TimePickerDialog(initialTime: initialTime),
                            ),
                          );
                          if (selectedTime != null) {}
                        },
                      ),

                      DateTimeSelection(
                        title: MyString.dateString,
                        onTap: () async {
                          DateTime? selectedDate =
                              await showModalBottomSheet<DateTime>(
                            context: context,
                            builder: (context) {
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

                                    /// Use a custom Calendar widget or a GridView for dates
                                    Expanded(
                                      child: CalendarDatePicker(
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        onDateChanged: (date) {},
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                          if (selectedDate != null) {}
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () {},
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
                            onPressed: () {},
                            minWidth: 150,
                            color: MyColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            height: 50,
                            child: Text(
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
