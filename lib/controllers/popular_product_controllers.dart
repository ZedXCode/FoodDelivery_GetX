import 'package:flutter/material.dart';
import 'package:food_delivery_getx/controllers/cart_controller.dart';
import 'package:food_delivery_getx/data/repositories/popular_product_repo.dart';
import 'package:food_delivery_getx/models/cart_model.dart';
import 'package:food_delivery_getx/models/products_models.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];

  List<ProductModel> get popularProductList => _popularProductList;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItems = 0;

  int get inCartItem => _inCartItems + _quantity;
  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products!);
      print(Product.fromJson(response.body).products.toString());
      _isLoaded = true;
      update();
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print("INCREMENT :: " + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print("DECREMENT :: " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "You can't reduce more !",
          backgroundColor: AppColors.mainColor, colorText: AppColors.white);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "You can't add more !",
          backgroundColor: AppColors.mainColor, colorText: AppColors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cartController, ProductModel product) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cartController;
    //check item is already added on cart or not
    var exists = false;
    exists = cartController.existInCart(product);
    //get from storage _inCartItems =
    print("exists or not :: " + exists.toString());
    print(
        "MY QUANTITY IS :: " + cartController.getQuantity(product).toString());
    if (exists) {
      _inCartItems = _cart.getQuantity(product);
    }
   // print("the quantity in the cart is :: " + _inCartItems.toString());
  }

  void addItem(ProductModel productModel) {
    //if(_quantity > 0){
    _cart.addItem(productModel, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(productModel);
    _cart.items.forEach((key, value) {
      print("The Id is " +
          value.id.toString() +
          " The Quantity is : " +
          value.quantity.toString());
    });
    /*}else{
      Get.snackbar("Item Count", "You should at least add one item in the cart!",
      backgroundColor: AppColors.mainColor, colorText: AppColors.white);
    }*/
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

}
