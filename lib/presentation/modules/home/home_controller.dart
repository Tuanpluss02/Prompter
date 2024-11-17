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

  getNewsFeed() async {
    final List<PostEntity> posts = await _postService.getNewsFeed();
    newsFeed.clear();
    for (final post in posts) {
      final author = await _userService.getUserById(post.authorId ?? '');
      newsFeed.add((post: post, author: author!));
    }
    newsFeed.refresh();
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
