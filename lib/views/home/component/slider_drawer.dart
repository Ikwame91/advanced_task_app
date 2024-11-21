import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class SliderDrawerWidget extends StatefulWidget {
  const SliderDrawerWidget({super.key, required this.drawerKey});
  final GlobalKey<SliderDrawerState> drawerKey;
  @override
  State<SliderDrawerWidget> createState() => _SliderDrawerWidgetState();
}

class _SliderDrawerWidgetState extends State<SliderDrawerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// toggle for drawer and icon aniamtion
  void toggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        controller.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        controller.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 132,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Animated Icon - Menu & Close
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: controller,
                    size: 30,
                  ),
                  onPressed: toggle),
            ),

            //Delete Icon
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  // base.isEmpty
                  //     ? warningNoTask(context)
                  //     : deleteAllTask(context);
                },
                child: const Icon(
                  CupertinoIcons.trash,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// /// My App Bar
// class MyAppBar extends StatefulWidget {
//   MyAppBar({Key? key, 
//     required this.drawerKey,
//   }) : super(key: key);
//   GlobalKey<SliderDrawerWidgetState> drawerKey;

//   @override
//   State<MyAppBar> createState() => _MyAppBarState();

// }

// class _MyAppBarState extends State<MyAppBar>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   bool isDrawerOpen = false;

//   @override
//   void initState() {
//     super.initState();

//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   /// toggle for drawer and icon aniamtion
//   void toggle() {
//     setState(() {
//       isDrawerOpen = !isDrawerOpen;
//       if (isDrawerOpen) {
//         controller.forward();
//         widget.drawerKey.currentState!.openSlider();
//       } else {
//         controller.reverse();
//         widget.drawerKey.currentState!.closeSlider();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var base = BaseWidget.of(context).dataStore.box;
//     return SizedBox(
//       width: double.infinity,
//       height: 132,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             /// Animated Icon - Menu & Close
//             Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: IconButton(
//                   splashColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                   icon: AnimatedIcon(
//                     icon: AnimatedIcons.menu_close,
//                     progress: controller,
//                     size: 40,
//                   ),
//                   onPressed: toggle),
//             ),

//             /// Delete Icon
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: GestureDetector(
//                 onTap: () {
//                   base.isEmpty
//                       ? warningNoTask(context)
//                       : deleteAllTask(context);
//                 },
//                 child: const Icon(
//                   CupertinoIcons.trash,
//                   size: 40,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

