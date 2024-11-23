import 'package:base/common/constants/app_type.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  final RefreshController newsFeedRefreshController = RefreshController();
  final RefreshController postDetailRefreshController = RefreshController();
  final PostService _postService = Get.find<PostService>();
  final UserService _userService = Get.find<UserService>();
  final newsFeed = <NewsFeedPost>[].obs;

  addNewPost(PostEntity post) async {
    final author = await _userService.getUserById(post.authorId ?? '');
    newsFeed.insert(0, NewsFeedPost(post: post, author: author!));
    newsFeed.refresh();
  }

  getNewsFeed({bool mustRefresh = false}) async {
    final List<PostEntity> posts = await _postService.getNewsFeed();
    newsFeed.clear();
    for (final post in posts) {
      final author = await _userService.getUserById(post.authorId ?? '');
      newsFeed.add(NewsFeedPost(post: post, author: author!));
    }
    if (mustRefresh) newsFeed.refresh();
  }

  bool isPostLiked(NewsFeedPost news) {
    return news.post.likes?.contains(appProvider.user.value.id) ?? false;
  }

  likePost(NewsFeedPost postToLike) async {
    final isLiked = isPostLiked(postToLike);
    final index = newsFeed.indexWhere((element) => element.post.id == postToLike.post.id);
    if (isLiked) {
      newsFeed[index].post.likes?.remove(appProvider.user.value.id);
    } else {
      newsFeed[index].post.likes?.add(appProvider.user.value.id ?? '');
    }
    update(['post_${postToLike.post.id!}']);
    _postService.updatePostLike(appProvider.user.value.id ?? '', postToLike.post.id ?? '');
  }

  @override
  void onReady() {
    getNewsFeed();
    super.onReady();
  }

  void onRefresh() async {
    await getNewsFeed();
    newsFeedRefreshController.refreshCompleted();
  }

  void updatePost(PostEntity postNeedEdit) {
    final index = newsFeed.indexWhere((element) => element.post.id == postNeedEdit.id);
    newsFeed[index].post = postNeedEdit;
    update(['post_${postNeedEdit.id!}']);
    newsFeed.refresh();
  }
}
