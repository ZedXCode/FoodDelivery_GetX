import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_getx/controllers/popular_product_controllers.dart';
import 'package:food_delivery_getx/controllers/recommended_product_controller.dart';
import 'package:food_delivery_getx/helper/route_helper.dart';
import 'package:food_delivery_getx/utils/dimentions.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _loadResources();
    //.. Operator create instance first and access its methods
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))..forward();
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(child: Image.asset("assets/image/logo part 1.png", width: Dimentions.splashScreenImage,))),
          Center(child: Image.asset("assets/image/logo part 2.png", width: Dimentions.splashScreenImage,))
        ],
      ),
    );
  }

  Future<void> _loadResources() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
}
