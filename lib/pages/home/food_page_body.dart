import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_getx/controllers/popular_product_controllers.dart';
import 'package:food_delivery_getx/controllers/recommended_product_controller.dart';
import 'package:food_delivery_getx/helper/route_helper.dart';
import 'package:food_delivery_getx/models/products_models.dart';
import 'package:food_delivery_getx/utils/app_constants.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:food_delivery_getx/utils/dimentions.dart';
import 'package:food_delivery_getx/widgets/BigText.dart';
import 'package:food_delivery_getx/widgets/SmallText.dart';
import 'package:food_delivery_getx/widgets/app_column.dart';
import 'package:food_delivery_getx/widgets/item_and_text_widget.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimentions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        //print("current page value:" + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  PageController pageController = PageController(
    viewportFraction: 0.85,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          //print("size is here ::: " + popularProducts.popularProductList.length.toString());
          return popularProducts.isLoaded
              ? Container(
                  height: Dimentions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //dots indicator
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimentions.height30,
        ),
        //popular text
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimentions.width10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: '.',
                    color: Colors.black26,
                  )),
              SizedBox(
                width: Dimentions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: 'Food Pairing',
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: Dimentions.height20,
        ),
        //List of food and IMages
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProductsController) {
          var recommendedProduct =
              recommendedProductsController.recommendedProductList;
          //print("Size is  ::" + recommendedProduct.length.toString());
          return recommendedProductsController.isLoaded
              ? Container(
                  height: 700,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recommendedProduct.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Dimentions.width20,
                                right: Dimentions.width20,
                                top: Dimentions.height10,
                                bottom: Dimentions.height10),
                            child: Row(
                              children: [
                                //Image section
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimentions.radius20),
                                      color: Colors.white38,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(AppConstant
                                                  .BASE_URL +
                                              AppConstant.UPLOAD_URL +
                                              recommendedProduct[index].img!))),
                                ),
                                //text
                                Expanded(
                                  child: Container(
                                    height: Dimentions.listViewTextContainer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Dimentions.radius20),
                                          bottomRight: Radius.circular(
                                              Dimentions.radius20)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimentions.width10,
                                          right: Dimentions.width10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BigText(
                                              text: recommendedProduct[index]
                                                      .name ??
                                                  ""),
                                          SizedBox(
                                            height: Dimentions.height10,
                                          ),
                                          SmallText(
                                              text:
                                                  "Chienese data is correct for Today" ??
                                                      ""),
                                          SizedBox(
                                            height: Dimentions.height10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconAndTextWidget(
                                                  icon: Icons.circle_sharp,
                                                  text: 'Normal',
                                                  iconColor:
                                                      AppColors.iconColor1),
                                              IconAndTextWidget(
                                                  icon: Icons.location_on,
                                                  text: '1.7km',
                                                  iconColor:
                                                      AppColors.mainColor),
                                              IconAndTextWidget(
                                                  icon:
                                                      Icons.access_time_rounded,
                                                  text: '32min',
                                                  iconColor:
                                                      AppColors.iconColor2)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int position, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (position == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - position) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - position + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - position) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(position, "home"));
            },
            child: Container(
              height: Dimentions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimentions.width10, right: Dimentions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius30),
                  color:
                      position.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstant.BASE_URL +
                          AppConstant.UPLOAD_URL +
                          popularProduct.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimentions.width30,
                  right: Dimentions.width30,
                  bottom: Dimentions.width30),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ],
                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                  color: Colors.white),
              child: Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: AppColumn(
                  text: popularProduct.name!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
