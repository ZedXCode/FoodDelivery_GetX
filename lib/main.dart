import 'package:flutter/material.dart';
import 'package:food_delivery_getx/controllers/cart_controller.dart';
import 'package:food_delivery_getx/controllers/popular_product_controllers.dart';
import 'package:food_delivery_getx/controllers/recommended_product_controller.dart';
import 'package:food_delivery_getx/helper/route_helper.dart';
import 'package:food_delivery_getx/pages/cart/cart_page.dart';
import 'package:food_delivery_getx/pages/food/popular_food_details.dart';
import 'package:food_delivery_getx/pages/food/recommened_food_details.dart';
import 'package:food_delivery_getx/pages/home/food_page_body.dart';
import 'package:food_delivery_getx/pages/home/main_food_page.dart';
import 'package:food_delivery_getx/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();//initialize dependencies data
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    //it is necessary because this is keep data and controllers in memory
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          //home: MainFoodPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });

  }
}

