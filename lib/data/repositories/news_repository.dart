import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/models/request/news_by_category_request.dart';
import 'package:base/data/models/request/search_news_request.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/api_result.dart';

class NewsApiPath {
  static String news(int top) => '/public/news/top-news/$top';
  static String newsDetail(String slug) => '/public/news/details/$slug';

  static String listCategory({String cd = 'NEWS_TOPIC'}) =>
      '/public/cate/list/$cd';
  static String discover = '/public/news/discovery';
  static String search = '/public/news/search';
  static String getNewsByCategory(String val) => '/public/news/cate/$val';
}

class NewsRepository extends BaseRepository {
  NewsRepository() : super(baseUrl: AppStrings.baseUrlNews);

  Future<ApiResult> fetchNews({required int top}) async {
    return handleApiRequest(() => dioClient.get(NewsApiPath.news(top)));
  }

  Stream<String> getSseBoardPrice() {
    return dioClient.connectToSSE(AppStrings.sseBoardPrice);
  }

  Future<ApiResult> getAppBoardPrice() async {
    return handleApiRequest(() => dioClient.get(AppStrings.appBoardPrice));
  }

  Future<ApiResult> fetchNewsDetail({required String slug}) async {
    return handleApiRequest(() => dioClient.get(NewsApiPath.newsDetail(slug)));
  }

  Future<ApiResult> fetchListCategory() async {
    return handleApiRequest(() => dioClient.get(NewsApiPath.listCategory()));
  }

  Future<ApiResult> fetchDiscoverNews() async {
    return handleApiRequest(() => dioClient.get(NewsApiPath.discover));
  }

  Future<ApiResult> searchNews(SearchNewsRequest request) async {
    return handleApiRequest(
        () => dioClient.post(NewsApiPath.search, data: request.toJson()));
  }

  Future<ApiResult> getNewsByCategory(NewsByCategoryRequest request) async {
    return handleApiRequest(
      () => dioClient.post(NewsApiPath.getNewsByCategory(request.val),
          data: request.toJson()),
    );
  }
}
