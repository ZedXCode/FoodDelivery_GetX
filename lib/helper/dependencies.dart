import 'package:food_delivery_getx/controllers/cart_controller.dart';
import 'package:food_delivery_getx/controllers/popular_product_controllers.dart';
import 'package:food_delivery_getx/controllers/recommended_product_controller.dart';
import 'package:food_delivery_getx/data/api/api_client.dart';
import 'package:food_delivery_getx/data/repositories/cart_repo.dart';
import 'package:food_delivery_getx/data/repositories/popular_product_repo.dart';
import 'package:food_delivery_getx/data/repositories/recommended_product_repo.dart';
import 'package:food_delivery_getx/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*Future<void> init() async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_URL));

  //repos
  Get.lazyPut(() => CartRepo());
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find())); //flutter will find automatically make sure class name is same
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  //controller
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
}*/
Future<void> init() async {

  final SharedPreferences pref = await SharedPreferences.getInstance();

  await Get.putAsync(() async {return pref;});
  await Get.putAsync(() async {return ApiClient(appBaseUrl: AppConstant.BASE_URL);});
  await Get.putAsync(() async {return PopularProductRepo(apiClient: Get.find());});
  await Get.putAsync(() async {return RecommendedProductRepo(apiClient: Get.find());});
  await Get.putAsync(() async {return CartRepo(pref: Get.find());});
  await Get.putAsync(() async {return PopularProductController(popularProductRepo: Get.find());});
  await Get.putAsync(() async {return RecommendedProductController(recommendedProductRepo: Get.find());});
  await Get.putAsync(() async {return CartController(cartRepo: Get.find());});
}