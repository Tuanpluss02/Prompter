import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/api_result.dart';

class PublicResourceApiPath {
  static String banners = '/banners';
}

class PublicResourceRepository extends BaseRepository {
  PublicResourceRepository() : super(baseUrl: AppStrings.baseUrlPublicResource);

  Future<ApiResult> getPublicBanner() async {
    return handleApiRequest(() => dioClient.get(PublicResourceApiPath.banners));
  }
}
