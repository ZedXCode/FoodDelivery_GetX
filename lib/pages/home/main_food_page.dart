import 'package:flutter/material.dart';
import 'package:food_delivery_getx/pages/home/food_page_body.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:food_delivery_getx/utils/dimentions.dart';
import 'package:food_delivery_getx/widgets/BigText.dart';
import 'package:food_delivery_getx/widgets/SmallText.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //showing border
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimentions.height10, bottom: Dimentions.height7),
                padding: EdgeInsets.only(
                    left: Dimentions.width10, right: Dimentions.width10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: 'India',
                          color: AppColors.mainColor,
                          size: 30,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "City",
                              color: Colors.black54,
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                            )
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimentions.height45,
                        height: Dimentions.height45,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius15),
                            color: AppColors.mainColor),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimentions.iconSize24, //24 default flutter size
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //showing body
            Expanded(child: SingleChildScrollView(child: FoodPageBody()))
          ],
        ),
      ),
    );
  }
}
