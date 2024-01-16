import 'package:food_delivery_getx/data/repositories/recommended_product_repo.dart';
import 'package:food_delivery_getx/models/products_models.dart';
import 'package:food_delivery_getx/utils/colors.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];

  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products!);
      _isLoaded = true;
      update();
    }
  }

  void setQuantity(bool isIncrement) {
    if(!isIncrement && _quantity <= 0){
      Get.snackbar("Item Count", "You can't reduce more !",
      backgroundColor: AppColors.mainColor,
      colorText: AppColors.white);
      return;
    }
    if(isIncrement && _quantity >= 10){
      Get.snackbar("Item Count", "You can't add more !",
      backgroundColor: AppColors.mainColor,
      colorText: AppColors.white);
      return;
    }
    if (isIncrement) {
      _quantity = _quantity + 1;
    } else {
      _quantity = _quantity - 1;
    }
    update();
  }

  void initProduct(){
    _quantity = 0;
  }
}
