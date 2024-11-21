import 'package:advanced_taskapp/utils/colors.dart';
import 'package:advanced_taskapp/utils/constants.dart';
import 'package:advanced_taskapp/utils/strings.dart';
import 'package:advanced_taskapp/views/home/widgets/floating_taskwidget.dart';
import 'package:advanced_taskapp/views/home/widgets/task_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> testing = [1, 3, 4];

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
                const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    value: 1 / 3,
                    valueColor: AlwaysStoppedAnimation(MyColors.primaryColor),
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
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Divider(
              thickness: 2,
              indent: 80,
            ),
          ),

          SizedBox(
              height: MediaQuery.of(context).size.height - 190,
              child: testing.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: testing.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                            direction: DismissDirection.horizontal,
                            onDismissed: (_) {
                              setState(() {
                                testing.removeAt(index);
                              });
                            },
                            background: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  MyString.deleteTask,
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            key: Key(
                              index.toString(),
                            ),
                            child: const TaskWidget());
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Lottie.asset(
                              lottieURL,
                              animate: testing.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
                        FadeInUp(
                            from: 30,
                            child: const Text(
                              MyString.doneAllTask,
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ))
        ]),
      ),
    );
  }
}
