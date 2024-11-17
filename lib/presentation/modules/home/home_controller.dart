import 'package:base/common/constants/app_strings.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  final RefreshController refreshController = RefreshController();
  final List<PostEntity> posts = [
    PostEntity(
      id: '1',
      authorId: 'Dw5wgm3HeiaFuOj4Daf6c03h7Xj1',
      authorAvatarUrl: AppStrings.defaultNetworkAvatar,
      authorDisplayName: 'Tuan Do',
      authorUsername: 'tuanpluss02',
      images: [
        AppStrings.defaultNetworkAvatar,
        AppStrings.defaultNetworkCover,
        AppStrings.defaultNetworkAvatar,
      ],
      likes: List.generate(18798532, (index) => 'Dw5wgm3HeiaFuOj4Daf6c03h7Xj1'),
      comments: List.generate(43745365, (index) => 'Dw5wgm3HeiaFuOj4Daf6c03h7Xj1'),
      content: '''
Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.
This is a sample text with a #hashtag, a mention <@123>, and a URL: https://youtube.com.
''',
      createdAt: DateTime.now(),
    ),
    PostEntity(
      id: '1',
      authorId: 'Dw5wgm3HeiaFuOj4Daf6c03h7Xj1',
      authorAvatarUrl: AppStrings.defaultNetworkAvatar,
      authorDisplayName: 'Tuan Do',
      authorUsername: 'tuanpluss02',
      images: [],
      likes: List.generate(657658, (index) => 'Dw5wgm3HeiaFuOj4Daf6c03h7Xj1'),
      comments: List.generate(21454343, (index) => 'Dw5wgm3HeiaFuOj4Daf6c03h7Xj1'),
      content: '''
Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.
This is a sample text with a #hashtag, a mention <@123>, and a URL: https://facebook.com.
''',
      createdAt: DateTime.now(),
    ),
  ];

  void onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }
}
