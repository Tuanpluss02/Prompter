import 'package:base/data/models/request/qr_money_request.dart';
import 'package:base/services/api_result.dart';

import 'base_repository.dart';

class PaymentPath {
  static String deposit = '/api/app/profile/deposit';
  static String qrMoney = '/api/app/money/qr';
  static String withdrawalRequest = '/api/app/money/withdrawalRequest';
  static String info = '/api/app/money/loadinfo';
}

class PaymentRepository extends BaseRepository {
  PaymentRepository() : super(baseUrl: 'http://172.16.90.85:8801');

  Future<ApiResult> getDeposit() async {
    return handleApiRequest(() => dioClient.get(PaymentPath.deposit));
  }

  Future<ApiResult> qrPayment(QrMoneyRequest qrMoneyRequest) async {
    return handleApiRequest(() =>
        dioClient.post(PaymentPath.qrMoney, data: qrMoneyRequest.toJson()));
  }

  Future<ApiResult> withdrawalMoney(QrMoneyRequest qrMoneyRequest) async {
    return handleApiRequest(() => dioClient.post(PaymentPath.withdrawalRequest,
        data: qrMoneyRequest.toJson()));
  }

  Future<ApiResult> getInfo() async {
    return handleApiRequest(() => dioClient.post(
          PaymentPath.info,
        ));
  }
}
