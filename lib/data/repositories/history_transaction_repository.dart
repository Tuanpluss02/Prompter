import 'package:base/app/constants/app_strings.dart';
import 'package:base/app/utils/conver_time.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/api_result.dart';

class HistoryTransactionsApiPath {
  static String history(
          int tab, int pgSize, int pgIndex, String startDate, String endDate) =>
      '/trans/$tab/$pgSize/$pgIndex/$startDate/$endDate';
}

class HistoryTransactionRepository extends BaseRepository {
  HistoryTransactionRepository()
      : super(baseUrl: AppStrings.baseUrlHistoryTransaction);

  Future<ApiResult> fetchHistoryTransaction(
      {int tab = 0,
      int pgSize = 10,
      int pgIndex = 1,
      String? startDate,
      String? endDate}) async {
    startDate = startDate ??
        convertDateTimetoYYYYMMDDFormat(
            DateTime.now().subtract(const Duration(days: 30)));
    endDate = endDate ?? convertDateTimetoYYYYMMDDFormat(DateTime.now());

    return handleApiRequest(() => dioClient.get(
        HistoryTransactionsApiPath.history(
            tab, pgSize, pgIndex, startDate!, endDate!)));
  }
}
