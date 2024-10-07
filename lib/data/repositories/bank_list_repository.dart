import 'package:base/services/api_result.dart';

import 'base_repository.dart';

class BankListPath {
  static String bankList = '/public/cate/list/BANK_LIST';
}

class BankListRepository extends BaseRepository {
  BankListRepository() : super(baseUrl: 'http://172.16.90.85:8802');

  Future<ApiResult> getBankList() async {
    return handleApiRequest(() => dioClient.get(BankListPath.bankList));
  }
}
