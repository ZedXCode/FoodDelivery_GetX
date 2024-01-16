import 'package:food_delivery_getx/data/repositories/cart_repo.dart';
import 'package:food_delivery_getx/models/cart_model.dart';
import 'package:food_delivery_getx/models/products_models.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  //Only storage and store to sharedPreferences
  List<CartModel> storageItems = [];

  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    var totalQunatity = 0;
    print("length of the items is :" + _items.length.toString());
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQunatity = value.quantity! + quantity;

        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            productModel: product);
      });

      if (totalQunatity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          print("Add item to cart " + product.id.toString() + " Quantity : " +
              quantity.toString());
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              productModel: product);
        });
      } else {
        Get.snackbar("Item Count", "You should at least add an item in cart",
            backgroundColor: AppColors.mainColor, colorText: AppColors.white);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel productModel) {
    var quantity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> cartModelItems) {
    storageItems = cartModelItems;

    for(int i=0; i <storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].productModel!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistory();
    clearCart();
  }

  void clearCart(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }
}
