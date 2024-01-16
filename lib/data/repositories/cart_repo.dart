import 'dart:convert';

import 'package:food_delivery_getx/models/cart_model.dart';
import 'package:food_delivery_getx/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences pref;

  CartRepo({required this.pref});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    pref.remove(AppConstant.CART_LIST);
    pref.remove(AppConstant.CART_HISTORY_LIST);
    var time = DateTime.now().toString();
    cart = [];
    //convert objects to string bcz sharedprefrence only save Strigs

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    pref.setStringList(AppConstant.CART_LIST, cart);
    //print(pref.getStringList(AppConstant.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> cartString = [];
    if (pref.containsKey(AppConstant.CART_LIST)) {
      cartString = pref.getStringList(AppConstant.CART_LIST)!;
    }
    List<CartModel> cartList = [];

    cartString.forEach(
            (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    print("Inside the getCart" + cartString.toString());
    return cartList;
  }

  void addToCartHistory() {
    if (pref.containsKey(AppConstant.CART_HISTORY_LIST)) {
      cartHistory = pref.getStringList(AppConstant.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("HIstory List : " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    pref.setStringList(AppConstant.CART_HISTORY_LIST, cartHistory);
    print(
        "The Length of history is : " + getCartHistoryList().length.toString());
  }

  List<CartModel> getCartHistoryList() {
    if (pref.containsKey(AppConstant.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory.addAll(pref.getStringList(AppConstant.CART_HISTORY_LIST)!);
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void removeCart() {
    cart = [];
    pref.remove(AppConstant.CART_LIST);
  }

}
