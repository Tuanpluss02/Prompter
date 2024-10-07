import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/models/request/search_request.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/api_result.dart';

class SearchApiPath {
  static String recentSearch() => '/board-price/search/recently';
  static const String search = '/board-price';
}

class SearchRepository extends BaseRepository {
  SearchRepository() : super(baseUrl: AppStrings.baseUrlSearch);

  Future<ApiResult> getRecentSearch() async {
    return handleApiRequest(() => dioClient.get(SearchApiPath.recentSearch()));
  }

  Future<ApiResult> getSearch(SearchRequest request) async {
    return handleApiRequest(() => dioClient.post(
          SearchApiPath.search,
          data: request.toJson(),
        ));
  }
}
