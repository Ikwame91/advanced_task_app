import 'package:advanced_taskapp/models/task.dart';
import 'package:advanced_taskapp/utils/strings.dart';
import 'package:flutter/material.dart';

class TopText extends StatelessWidget {
  const TopText({
    super.key,
    this.task,
    this.taskControllerForTitle,
  });

  final Task? task;
  final TextEditingController? taskControllerForTitle;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    bool isTasklreadyExists() {
      if (taskControllerForTitle?.text == null) {
        return true;
      } else {
        return false;
      }
    }

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
                text: isTasklreadyExists()
                    ? MyString.updateCurrentTask
                    : MyString.addNewTask,
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
