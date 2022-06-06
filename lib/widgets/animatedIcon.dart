import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimIconBox extends StatefulWidget {
  final AnimatedIconData? iconData;
  final String? name;

  const AnimIconBox({Key? key, this.iconData, this.name}) : super(key: key);

  @override
  _AnimIconDemoBoxState createState() => _AnimIconDemoBoxState();
}

// ! Add SingleTickerProviderStateMixin to use animation controllers.
class _AnimIconDemoBoxState extends State<AnimIconBox>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<HomeViewModelService>(
          init: Get.find(),
          builder: (homeViewModelService) => InkWell(
            onTap: () {
              // ! Depending on the state, reverse or forward the animation.
              if (_animationController!.isCompleted) {
                print("list");
                _animationController!.reverse();
              } else {
                print("grid");
                _animationController!.forward();
              }
              // set islist != islist
              homeViewModelService.onchangeListView();
            },
            child: AnimatedIcon(
              // ! Set the animation progress to our animation controller
              progress: _animationController!,
              icon: widget.iconData!,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
