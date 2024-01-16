import 'package:food_delivery_getx/data/api/api_client.dart';
import 'package:food_delivery_getx/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});


  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstant.POPULAR_PRODUCT_URI);
  }

}