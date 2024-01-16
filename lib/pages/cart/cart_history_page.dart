import 'package:flutter/material.dart';
import 'package:food_delivery_getx/controllers/cart_controller.dart';
import 'package:food_delivery_getx/utils/app_constants.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:food_delivery_getx/utils/dimentions.dart';
import 'package:food_delivery_getx/widgets/BigText.dart';
import 'package:food_delivery_getx/widgets/SmallText.dart';
import 'package:food_delivery_getx/widgets/app_icon.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    // Print the result
    print(cartItemsPerOrder);

    List<int> createOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = createOrderTimeToList(); //[3,2,3]
    print(itemsPerOrder);

    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimentions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(right: Dimentions.width10, left: Dimentions.width10, top: Dimentions.height30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: "Cart history",
                  color: AppColors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(
                    top: Dimentions.height20,
                    left: Dimentions.width20,
                    right: Dimentions.width20),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          height: Dimentions.height30*4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ((){
                                DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time.toString());
                                var inputDate = DateTime.parse(parseDate.toString());
                                var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                                var outputDate = outputFormat.format(inputDate);
                                return BigText(text: outputDate);
                              }()),

                              SizedBox(
                                height: Dimentions.height10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i],
                                        (index) {
                                      if (listCounter <
                                          getCartHistoryList.length) {
                                        listCounter++;
                                      }
                                      print("My list is  : : " +
                                          getCartHistoryList[listCounter - 1]
                                              .img
                                              .toString());
                                      return index <= 2
                                          ? Container(
                                              height: Dimentions.height20*4,
                                              width: Dimentions.width20*4,
                                              margin: EdgeInsets.only(
                                                  right:
                                                      Dimentions.width10 / 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimentions.radius15 /
                                                              2),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstant.BASE_URL +
                                                              AppConstant
                                                                  .UPLOAD_URL +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!))),
                                            )
                                          : Container();
                                    }),
                                  ),
                                  Container(
                                    height: Dimentions.height20*4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SmallText(
                                          text: "Total",
                                          color: AppColors.titleColor,
                                        ),
                                        BigText(
                                          text: itemsPerOrder[i].toString() +
                                              " Items",
                                          color: AppColors.titleColor,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimentions.width10,
                                              vertical:
                                                  Dimentions.height10 / 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimentions.radius15 / 3),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.mainColor)),
                                          child: SmallText(
                                            text: "One More",
                                            color: AppColors.mainColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: Dimentions.height20),
                        )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
