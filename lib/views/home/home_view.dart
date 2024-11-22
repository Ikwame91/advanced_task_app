import 'package:advanced_taskapp/utils/colors.dart';
import 'package:advanced_taskapp/utils/constants.dart';
import 'package:advanced_taskapp/utils/strings.dart';
import 'package:advanced_taskapp/views/home/component/custom_slider.dart';
import 'package:advanced_taskapp/views/home/component/slider_drawer.dart';
import 'package:advanced_taskapp/views/home/widgets/floating_taskwidget.dart';
import 'package:advanced_taskapp/views/home/widgets/task_widget.dart';
import 'package:advanced_taskapp/views/tasks/widgets/tasktextfield.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController controller = TextEditingController();
  final List<int> testing = [];
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

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
            child: _buildBody(textTheme, context),
          )),
    );
  }

  Widget _buildBody(TextTheme textTheme, BuildContext context) {
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
              const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  value: 1 / 3,
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
        TaskTextField(controller: controller),
       

        Flexible(
          child: SizedBox(
              height: MediaQuery.of(context).size.height - 190,
              child: testing.isNotEmpty
                  //task list is not empty
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
                  //task list is empty
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //lottie animation

                        FadeIn(
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            //lottie animation
                            // child: Lottie.asset(
                            //   lottieURL,
                            //   animate: testing.isNotEmpty ? false : true,
                            // ),
                          ),
                        ),
                        //sub text
                        FadeInUp(
                            from: 30,
                            child: const Text(
                              MyString.doneAllTask,
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    )),
        )
      ]),
    );
  }
}
