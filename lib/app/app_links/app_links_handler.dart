import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:base/app/utils/log.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// cách xử lý app links khi bị vướng authen
// mỗi màn hình cần authen để truy cập nên có thêm một biến để đánh dấu rằng nó được mở bằng app link
// nếu trong màn hình đó xuất hiện logic đẩy người dùng về màn đăng nhập thì sẽ lưu lại app link để đánh dấu
// tại màn login, sau khi login thành công thì sẽ gọi lại hàm handle app link và truyền lại app link đã lưu

class AppLinksHandler {
  AppLinksHandler();

  // app links intance
  final AppLinks _appLinks = AppLinks();

  // app links subscription
  StreamSubscription<Uri>? _linkSubscription;

  // "Ổn định": tức là các logic route đã chạy xong, không còn navigator nữa

  // vì không rõ thời điểm event mở app bằng link, event được gửi lên khi nào
  // nên tốt nhất là xử lý thủ công bằng hàm handleFirst() sau => khi splash screen ổn định
  //
  // vì:
  // 1. nếu listener được đăng kí ở sau splash => có thể lần đầu đăng kí sẽ không kịp nhận được event mở app bằng link
  // 2. nếu listener được đăng kí và nghe được event trước splash screen => có thể xảy ra lỗi vì sau khi route đã được push nhưng bị các logic route ở splash screen làm loạn
  // 3. nếu listener được đăng kí và nghe được event trước splash screen, sớm đến mức ở main hoặc ở my app => có thể dẫn đến gọi route khi material app chưa tồn tại
  // 4. dù có đặt addPostFrameCallback thì nó cũng sẽ gọi ngay sau khi intial route tức splash screen được build xong => nhưng mấy logic route trong splash screen cũng chạy sau khi splash screen được build xong => loạn
  //
  // => lần đầu gọi thủ công handle để xử lý => sau khi splash screen ổn định là ổn nhất, vì ở đó đủ sớm để xử lý, đủ muộn để tránh lỗi
  // => listener thì cứ đăng kí ngay tại material app hoặc my app vì cần dispose ở đó, đặt ở nơi khác thì subscribe có thể bị dispose sớm
  // chỉ cần handle thủ công 1 lần khi app mở, sau đó thì listener sẽ tự động nghe suất quá trình app chạy mà không có lỗi gì
  bool _isFirstHandleAfterOpen = true;

  // nếu là gọi để xử lý lần đầu sau khi app được mở bằng link (sau splash screen) thì không cần truyền uri vào
  // nếu là gọi để xử lý lai sau khi bị yêu cầu authen thì cần truyền uri vào
  Future<void> handle({Uri? uri}) async {
    Uri? tmpUri = await _appLinks.getLatestLink();
    _handleAppLink(uri ?? tmpUri ?? Uri.parse(''));
    _isFirstHandleAfterOpen = false;
  }

  Future<void> registerListener() async {
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (_isFirstHandleAfterOpen) return;
      _handleAppLink(uri);
    });
  }

  void dispose() {
    _linkSubscription?.cancel();
  }

  // chỉ sử dưới này khi cần xử lý thêm app links
  void _handleAppLink(Uri uri) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Log.console('AppLinkHandler');
      _handleUri(uri);
    });
  }

  void _handleUri(Uri uri) {
    final List<String> pathSegments = uri.pathSegments;

    // xử lý link theo pathSegments
    if (pathSegments.contains('news')) _handelNewsLink(pathSegments.last);
  }

  void _handelNewsLink(String slug) {
    //TODO: edit route
    Get.toNamed(AppRoutes.login, arguments: slug);
  }
}
