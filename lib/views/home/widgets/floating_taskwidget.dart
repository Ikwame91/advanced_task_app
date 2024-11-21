import 'package:advanced_taskapp/utils/colors.dart';
import 'package:advanced_taskapp/views/tasks/tasks_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingTaskwidget extends StatelessWidget {
  const FloatingTaskwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => TasksView()));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
