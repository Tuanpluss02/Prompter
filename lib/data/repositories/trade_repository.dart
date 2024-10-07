import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/models/request/trade/execute_order_request.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/api_result.dart';

class TradeApiPath {
  static String executeOrder = '/api/app/money/execute-order';
  static String getInvestInformation({required int productId}) =>
      '/api/app/product/$productId';
  static String getInvestmentPack({required int productId}) =>
      '/api/app/cate/cd/$productId/${AppStrings.apiVersion}';
}

class TradeRepository extends BaseRepository {
  TradeRepository() : super(baseUrl: AppStrings.serverHost1);

  Future<ApiResult> executeOrder(
      ExecuteOrderRequest executeOrderRequest) async {
    return handleApiRequest(() => dioClient.post(TradeApiPath.executeOrder,
        data: executeOrderRequest.toJson()));
  }

  Future<ApiResult> getInvestmentPack({required int productId}) {
    return handleApiRequest(() =>
        dioClient.get(TradeApiPath.getInvestmentPack(productId: productId)));
  }

  Future<ApiResult> getInvestInformation({required int productId}) {
    return handleApiRequest(() =>
        dioClient.get(TradeApiPath.getInvestInformation(productId: productId)));
  }
}
