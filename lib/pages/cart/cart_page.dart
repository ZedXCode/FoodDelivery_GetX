import 'package:flutter/material.dart';
import 'package:food_delivery_getx/controllers/cart_controller.dart';
import 'package:food_delivery_getx/controllers/popular_product_controllers.dart';
import 'package:food_delivery_getx/helper/route_helper.dart';
import 'package:food_delivery_getx/utils/app_constants.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:food_delivery_getx/utils/dimentions.dart';
import 'package:food_delivery_getx/widgets/BigText.dart';
import 'package:food_delivery_getx/widgets/SmallText.dart';
import 'package:food_delivery_getx/widgets/app_icon.dart';
import 'package:get/get.dart';

/*class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {*/
class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);


  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimentions.height20 * 3,
              right: Dimentions.width20,
              left: Dimentions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: AppColors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimentions.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimentions.width20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: AppColors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimentions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: AppColors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimentions.iconSize24,
                  )
                ],
              )),
          Positioned(
              top: Dimentions.height20 * 5,
              left: Dimentions.width20,
              right: Dimentions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimentions.height15),

                /// color: Colors.red,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_, index) {
                          return Container(
                            height: 100,
                            width: double.maxFinite,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var popularIndex =
                                    Get
                                        .find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(
                                        _cartList[index].productModel!);
                                    if (popularIndex >= 0) {
                                      Get.toNamed(RouteHelper.getPopularFood(
                                          popularIndex, "cartpage"));
                                    } else {
                                      var recommendedIndex =
                                      Get
                                          .find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(
                                          _cartList[index].productModel!);
                                      Get.toNamed(
                                          RouteHelper.getRecommendedFood(
                                              recommendedIndex, "cartpage"));
                                    }
                                  },
                                  child: Container(
                                    width: Dimentions.height20 * 5,
                                    height: Dimentions.height20 * 5,
                                    margin: EdgeInsets.only(
                                        bottom: Dimentions.height10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                AppConstant.BASE_URL +
                                                    AppConstant.UPLOAD_URL +
                                                    cartController
                                                        .getItems[index].img!),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(
                                            Dimentions.radius20),
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimentions.width10,
                                ),
                                Expanded(
                                    child: Container(
                                      height: Dimentions.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: cartController
                                                .getItems[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].price!
                                                    .toString(),
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimentions.height10,
                                                    bottom: Dimentions.height10,
                                                    right: Dimentions.width10,
                                                    left: Dimentions.width10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        Dimentions.radius20)),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        print("testing");
                                                        cartController.addItem(
                                                            _cartList[index]
                                                                .productModel!,
                                                            -1);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColors
                                                            .signColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimentions
                                                          .width10 / 2,
                                                    ),
                                                    BigText(
                                                        text: _cartList[index]
                                                            .quantity
                                                            .toString() //productController.inCartItem.toString(),
                                                    ),
                                                    SizedBox(
                                                      width: Dimentions
                                                          .width10 / 2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(
                                                            _cartList[index]
                                                                .productModel!,
                                                            1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: AppColors
                                                            .signColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          );
                        });
                  }),
                ),
              ))
        ],
      ),
      bottomNavigationBar:
      GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimentions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimentions.height30,
              bottom: Dimentions.height30,
              left: Dimentions.width20,
              right: Dimentions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.radius20 * 2),
                  topRight: Radius.circular(Dimentions.radius20 * 2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimentions.height20,
                    bottom: Dimentions.height20,
                    right: Dimentions.width20,
                    left: Dimentions.width20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimentions.radius20)),
                child: Row(
                  children: [
                    SizedBox(
                      width: Dimentions.width10 / 2,
                    ),
                    BigText(
                      text: "\$ " + cartController.totalAmount.toString(),
                    ),
                    SizedBox(
                      width: Dimentions.width10 / 2,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                   cartController.addToHistory();
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimentions.height20,
                      bottom: Dimentions.height20,
                      right: Dimentions.width20,
                      left: Dimentions.width20),
                  child: BigText(
                    text:
                    "Checkout",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                      color: AppColors.mainColor),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}