import 'package:advanced_taskapp/utils/colors.dart';
import 'package:advanced_taskapp/utils/strings.dart';
import 'package:advanced_taskapp/views/home/widgets/floating_taskwidget.dart';
import 'package:advanced_taskapp/views/home/widgets/task_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      //Tab
      floatingActionButton: const FloatingTaskwidget(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(children: [
          /// custom appbar
          Container(
            margin: const EdgeInsets.only(left: 60, top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// CircularProgressIndicator
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    value: 1 / 3,
                    valueColor:
                        const AlwaysStoppedAnimation(MyColors.primaryColor),
                    backgroundColor: Colors.grey,
                    // value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),

                /// Texts
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyString.mainTitle, style: textTheme.displayLarge),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      " 1 0f 3",
                      style: textTheme.displayMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Divider(
              thickness: 2,
              indent: 80,
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height - 190,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 20,
              itemBuilder: (context, index) {
                return TaskWidget();
              },
            ),
          )
        ]),
      ),
    );
  }
}
