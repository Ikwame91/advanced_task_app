import 'package:advanced_taskapp/utils/strings.dart';
import 'package:advanced_taskapp/views/tasks/widgets/task_view_appbar.dart';
import 'package:advanced_taskapp/views/tasks/widgets/tasktextfield.dart';
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
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                TopText(textTheme: textTheme),
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

                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => SizedBox(
                              height: 220,
                              child: TimePickerDialog(
                             
                                ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(20),
                          height: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  MyString.timeString,
                                  style: textTheme.titleSmall,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 80,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                ),
                                child: Center(
                                  child: Text(
                                    "Time",
                                    style: textTheme.titleSmall,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )

                      /// Time Picker
                      // GestureDetector(
                      //   onTap: () {
                      //     DatePicker.showTimePicker(context,
                      //         showTitleActions: true,
                      //         showSecondsColumn: false,
                      //         onChanged: (_) {}, onConfirm: (selectedTime) {
                      //       setState(() {
                      //         if (widget.task?.createdAtTime == null) {
                      //           time = selectedTime;
                      //         } else {
                      //           widget.task!.createdAtTime = selectedTime;
                      //         }
                      //       });

                      //       FocusManager.instance.primaryFocus?.unfocus();
                      //     }, currentTime: showTimeAsDateTime(time));
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      //     width: double.infinity,
                      //     height: 55,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       border: Border.all(
                      //           color: Colors.grey.shade300, width: 1),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Text(MyString.timeString,
                      //               style: textTheme.headline5),
                      //         ),
                      //         Expanded(child: Container()),
                      //         Container(
                      //           margin: const EdgeInsets.only(right: 10),
                      //           width: 80,
                      //           height: 35,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               color: Colors.grey.shade100),
                      //           child: Center(
                      //             child: Text(
                      //               showTime(time),
                      //               style: textTheme.subtitle2,
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      // /// Date Picker
                      // GestureDetector(
                      //   onTap: () {
                      //     DatePicker.showDatePicker(context,
                      //         showTitleActions: true,
                      //         minTime: DateTime.now(),
                      //         maxTime: DateTime(2030, 3, 5),
                      //         onChanged: (_) {}, onConfirm: (selectedDate) {
                      //       setState(() {
                      //         if (widget.task?.createdAtDate == null) {
                      //           date = selectedDate;
                      //         } else {
                      //           widget.task!.createdAtDate = selectedDate;
                      //         }
                      //       });
                      //       FocusManager.instance.primaryFocus?.unfocus();
                      //     }, currentTime: showDateAsDateTime(date));
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      //     width: double.infinity,
                      //     height: 55,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       border: Border.all(
                      //           color: Colors.grey.shade300, width: 1),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Text(MyString.dateString,
                      //               style: textTheme.headline5),
                      //         ),
                      //         Expanded(child: Container()),
                      //         Container(
                      //           margin: const EdgeInsets.only(right: 10),
                      //           width: 140,
                      //           height: 35,
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               color: Colors.grey.shade100),
                      //           child: Center(
                      //             child: Text(
                      //               showDate(date),
                      //               style: textTheme.subtitle2,
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // )
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

  isTaskAlreadyExistBool() {}

  /// All Bottom Buttons
  // Padding _buildBottomButtons(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 20),
  //     child: Row(
  //       mainAxisAlignment: isTaskAlreadyExistBool()
  //           ? MainAxisAlignment.center
  //           : MainAxisAlignment.spaceEvenly,
  //       children: [
  //         isTaskAlreadyExistBool()
  //             ? Container()

  //             /// Delete Task Button
  //             : Container(
  //                 width: 150,
  //                 height: 55,
  //                 decoration: BoxDecoration(
  //                     border:
  //                         Border.all(color: MyColors.primaryColor, width: 2),
  //                     borderRadius: BorderRadius.circular(15)),
  //                 child: MaterialButton(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(15),
  //                   ),
  //                   minWidth: 150,
  //                   height: 55,
  //                   onPressed: () {
  //                     deleteTask();
  //                     Navigator.pop(context);
  //                   },
  //                   color: Colors.white,
  //                   child: Row(
  //                     children: const [
  //                       Icon(
  //                         Icons.close,
  //                         color: MyColors.primaryColor,
  //                       ),
  //                       SizedBox(
  //                         width: 5,
  //                       ),
  //                       Text(
  //                         MyString.deleteTask,
  //                         style: TextStyle(
  //                           color: MyColors.primaryColor,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
}

class TopText extends StatelessWidget {
  const TopText({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
                text: MyString.addNewTask,
                style: textTheme.headlineSmall,
                children: const [
                  TextSpan(
                    text: MyString.taskStrnig,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ]),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
