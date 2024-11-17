import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  final RefreshController refreshController = RefreshController();
  final PostService _postService = Get.find<PostService>();
  final newsFeed = <PostEntity>[].obs;

  @override
  void onReady() {
    getNewsFeed();
    super.onReady();
  }

  getNewsFeed() async {
    final List<PostEntity> posts = await _postService.getNewsFeed();
    newsFeed.addAll(posts);
    newsFeed.refresh();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }
}
