import 'package:food_delivery_getx/pages/cart/cart_page.dart';
import 'package:food_delivery_getx/pages/food/popular_food_details.dart';
import 'package:food_delivery_getx/pages/food/recommened_food_details.dart';
import 'package:food_delivery_getx/pages/home/home_page.dart';
import 'package:food_delivery_getx/pages/home/main_food_page.dart';
import 'package:food_delivery_getx/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String splashPage = "/splash-page";

  static String getInitial() => '$initial';

  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static String getCartPage() => '$cartPage';
  static String getSplashPage() => '$splashPage';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashPage()),
    GetPage(name: initial, page: () => HomePage()),
    //Popular Food Page
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    //Recommended
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    //CartPage
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
