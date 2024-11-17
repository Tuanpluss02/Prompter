import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef PostNewsFeed = ({PostEntity post, UserEntity author});

class HomeController extends BaseController {
  final RefreshController refreshController = RefreshController();
  final PostService _postService = Get.find<PostService>();
  final UserService _userService = Get.find<UserService>();
  final newsFeed = <PostNewsFeed>[].obs;

  @override
  void onReady() {
    getNewsFeed();
    super.onReady();
  }

  getNewsFeed({bool mustRefresh = false}) async {
    final List<PostEntity> posts = await _postService.getNewsFeed();
    newsFeed.clear();
    for (final post in posts) {
      final author = await _userService.getUserById(post.authorId ?? '');
      newsFeed.add((post: post, author: author!));
    }
    if (mustRefresh) newsFeed.refresh();
  }

  likePost(PostNewsFeed postToLike) async {
    final isLiked = isPostLiked(postToLike);
    final index = newsFeed.indexWhere((element) => element.post.id == postToLike.post.id);
    if (isLiked) {
      newsFeed[index].post.likes?.remove(appProvider.user.value.id);
    } else {
      newsFeed[index].post.likes?.add(appProvider.user.value.id ?? '');
    }
    await _postService.updatePostLike(appProvider.user.value.id ?? '', postToLike.post.id ?? '');
    newsFeed.refresh();
  }

  bool isPostLiked(PostNewsFeed news) {
    return news.post.likes?.contains(appProvider.user.value.id) ?? false;
  }

  addNewPost(PostEntity post) async {
    final author = await _userService.getUserById(post.authorId ?? '');
    newsFeed.insert(0, (post: post, author: author!));
    newsFeed.refresh();
  }

  void onRefresh() async {
    await getNewsFeed();
    refreshController.refreshCompleted();
  }
}
