
import 'package:advanced_taskapp/utils/colors.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///navigate to task view to view details about task
      },
      child: AnimatedContainer(
        margin:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 4),
                blurRadius: 10,
              )
            ]),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              //check or uncheck the icon
            },
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              duration: Duration(milliseconds: 600),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              top: 3,
            ),
            child: Text(
              'Done',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w400),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        "SubDate",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
