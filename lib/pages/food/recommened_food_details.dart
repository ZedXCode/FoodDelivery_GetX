import 'package:flutter/material.dart';
import 'package:food_delivery_getx/controllers/cart_controller.dart';
import 'package:food_delivery_getx/controllers/popular_product_controllers.dart';
import 'package:food_delivery_getx/controllers/recommended_product_controller.dart';
import 'package:food_delivery_getx/helper/route_helper.dart';
import 'package:food_delivery_getx/utils/app_constants.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:food_delivery_getx/utils/dimentions.dart';
import 'package:food_delivery_getx/widgets/BigText.dart';
import 'package:food_delivery_getx/widgets/app_icon.dart';
import 'package:food_delivery_getx/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetails extends StatelessWidget {
  int pageId;
  String page;

  RecommendedFoodDetails({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommendedProduct =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), recommendedProduct);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: AppIcon(icon: Icons.clear),
                  onTap: () {
                    if(page == "cartpage"){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.back();
                    }

                  },
                ),
                GetBuilder<PopularProductController>(
                    builder: (productController) {
                  return GestureDetector(
                      onTap: () {
                        if (productController.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          productController.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ))
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(
                        size: Dimentions.font26,
                        text: recommendedProduct.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimentions.radius20),
                        topRight: Radius.circular(Dimentions.radius20))),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstant.BASE_URL +
                    AppConstant.UPLOAD_URL +
                    recommendedProduct.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                  right: Dimentions.width20, left: Dimentions.width20),
              child: ExpandableTextWidget(
                  text: recommendedProduct.description ?? ""),
            ),
          )
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (productController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  right: Dimentions.width20 * 2.5,
                  left: Dimentions.width20 * 2.5,
                  top: Dimentions.height10,
                  bottom: Dimentions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      productController.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimentions.iconSize24,
                    ),
                  ),
                  BigText(
                    text: "\$ ${recommendedProduct.price} " +
                        " X " +
                        productController.inCartItem.toString(),
                    color: AppColors.mainBlackColor,
                    size: Dimentions.font26,
                  ),
                  GestureDetector(
                    onTap: () {
                      productController.setQuantity(true);
                    },
                    child: AppIcon(
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.iconSize24),
                  )
                ],
              ),
            ),
            Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius20)),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      productController.addItem(recommendedProduct);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimentions.height20,
                          bottom: Dimentions.height20,
                          right: Dimentions.width20,
                          left: Dimentions.width20),
                      child: BigText(
                        text: "\$ ${recommendedProduct.price} | Add to cart",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
