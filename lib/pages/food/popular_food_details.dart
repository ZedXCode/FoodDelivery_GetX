import 'package:flutter/material.dart';
import 'package:food_delivery_getx/controllers/cart_controller.dart';
import 'package:food_delivery_getx/controllers/popular_product_controllers.dart';
import 'package:food_delivery_getx/helper/route_helper.dart';
import 'package:food_delivery_getx/pages/cart/cart_page.dart';
import 'package:food_delivery_getx/utils/app_constants.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:food_delivery_getx/utils/dimentions.dart';
import 'package:food_delivery_getx/widgets/BigText.dart';
import 'package:food_delivery_getx/widgets/app_column.dart';
import 'package:food_delivery_getx/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../widgets/app_icon.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  final String page;
  PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              child: Container(
                width: double.maxFinite,
                height: Dimentions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstant.BASE_URL +
                            AppConstant.UPLOAD_URL +
                            product.img!))),
              ),
            ),
          ),
          //Icon widgets
          Positioned(
            top: Dimentions.height10,
            left: Dimentions.width20,
            right: Dimentions.height20,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if(page == 'cartpage'){
                          Get.toNamed(RouteHelper.getCartPage());
                        }else {
                          Get.back();
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(
                      builder: (productController) {
                    return GestureDetector(
                        onTap: (){
                          if(productController.totalItems >= 1) {
                            Get.toNamed(RouteHelper.getCartPage());
                          }
                        },
                        child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ))
                            : Container()
                      ],
                    ));
                  })
                ],
              ),
            ),
          ),
          //Introdctions of food
          Positioned(
              left: 0,
              right: 0,
              top: Dimentions.popularFoodImgSize - 20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimentions.width15,
                    right: Dimentions.width20,
                    top: Dimentions.height15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimentions.radius20),
                        topRight: Radius.circular(Dimentions.radius20)),
                    color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      BigText(text: 'Introduce'),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandableTextWidget(
                        text: product.description!,
                      )))
                    ]),
              )),
          //Expandable text widget
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (productController) {
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
                    GestureDetector(
                      onTap: () {
                        print("testing");
                        productController.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimentions.width10 / 2,
                    ),
                    BigText(
                      text: productController.inCartItem.toString(),
                    ),
                    SizedBox(
                      width: Dimentions.width10 / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        productController.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  productController.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimentions.height20,
                      bottom: Dimentions.height20,
                      right: Dimentions.width20,
                      left: Dimentions.width20),
                  child: BigText(
                    text:
                        "\$ ${productController.popularProductList[pageId].price.toString()} | Add to cart",
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
}
