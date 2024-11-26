import 'package:advanced_taskapp/main.dart';
import 'package:advanced_taskapp/models/task.dart';
import 'package:advanced_taskapp/utils/constants.dart';
import 'package:advanced_taskapp/utils/strings.dart';
import 'package:advanced_taskapp/views/home/component/custom_slider.dart';
import 'package:advanced_taskapp/views/home/component/slider_drawer.dart';
import 'package:advanced_taskapp/views/home/widgets/floating_taskwidget.dart';
import 'package:advanced_taskapp/views/home/widgets/task_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController controller = TextEditingController();
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  int checkDoneTask(List<Task> task) {
    int i = 0;
    for (Task doneTasks in task) {
      if (doneTasks.isCompleted) {
        i++;
      }
    }
    return i;
  }

  /// Checking The Value Of the Circle Indicator
  dynamic valueOfTheIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();

        // final task = base.dataStore.getSortedTasks(box);

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,

              //Tab
              floatingActionButton: const FloatingTaskwidget(),
              body: SliderDrawer(
                  key: drawerKey,
                  isDraggable: false,
                  animationDuration: 1000,
                  slider: CustomSlider(),
                  appBar: SliderDrawerWidget(
                    drawerKey: drawerKey,
                  ),
                  child: _buildBody(
                    textTheme,
                    base,
                    tasks,
                  ))),
        );
      },
    );
  }

  Widget _buildBody(
    TextTheme textTheme,
    BaseWidget base,
    List<Task> tasks,
  ) {
    return SizedBox(
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
                  value: tasks.isNotEmpty
                      ? checkDoneTask(tasks) / valueOfTheIndicator(tasks)
                      : 0.0,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  backgroundColor: Colors.grey,
                ),
              ),
              const SizedBox(width: 25),

              /// Texts
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(MyString.mainTitle, style: textTheme.displayLarge),
                  const SizedBox(
                    height: 3,
                  ),
                  Text("${checkDoneTask(tasks)} of ${tasks.length} task",
                      style: textTheme.titleMedium),
                ],
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Divider(
            thickness: 3,
            indent: 80,
          ),
        ),

        Flexible(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 190,
            child: tasks.isNotEmpty
                // Task list is not empty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (_) {
                          base.dataStore.dalateTask(task: task);
                        },
                        background: Container(
                          color: Colors.red.withOpacity(0.5),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_outline, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                MyString.deleteTask,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        key: Key(task.id),
                        child: TaskWidget(
                          onTaskUpdated: (){
                            setState(() {
                              
                            });
                          },
                         
                         
                          task: task),
                      );
                    },
                  )
                // Task list is empty
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie animation
                      FadeIn(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Lottie.asset(
                            lottieURL,
                            animate: tasks.isNotEmpty ? false : true,
                          ),
                        ),
                      ),
                      // Sub text
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          MyString.doneAllTask,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ]),
    );
  }
}
