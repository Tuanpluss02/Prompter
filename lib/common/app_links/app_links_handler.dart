import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:base/common/utils/log.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Handles app links and deep links for the application.
///
/// This class is responsible for managing app links and deep links,
/// including registering listeners, handling the links, and disposing of resources.
class AppLinksHandler {
  AppLinksHandler();

  // app links instance
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
  /// Handles the app link.
  ///
  /// This method handles the app link, either by using the provided URI or by getting the latest link.
  /// It is called manually the first time after the app is opened by a link (after the splash screen).
  Future<void> handle({Uri? uri}) async {
    Uri? tmpUri = await _appLinks.getLatestLink();
    _handleAppLink(uri ?? tmpUri ?? Uri.parse(''));
    _isFirstHandleAfterOpen = false;
  }

  /// Registers the listener for app links.
  ///
  /// This method registers the listener for app links and handles the app link when it is received.
  Future<void> registerListener() async {
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (_isFirstHandleAfterOpen) return;
      _handleAppLink(uri);
    });
  }

  /// Disposes of the resources used by the AppLinksHandler.
  ///
  /// This method cancels the app links subscription.
  void dispose() {
    _linkSubscription?.cancel();
  }

  // chỉ sử dưới này khi cần xử lý thêm app links
  /// Handles the app link.
  ///
  /// This method handles the app link by calling the _handleUri method.
  void _handleAppLink(Uri uri) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Log.console('AppLinkHandler');
      _handleUri(uri);
    });
  }

  /// Handles the URI.
  ///
  /// This method handles the URI by checking the path segments and calling the appropriate method.
  void _handleUri(Uri uri) {
    final List<String> pathSegments = uri.pathSegments;
    Log.console('AppLinkHandler: ${uri.pathSegments.toString()}');

    // xử lý link theo pathSegments
    if (pathSegments.contains('reset-password')) _handelResetPasswordLink(pathSegments.last);
  }

  /// Handles the news link.
  ///
  /// This method handles the news link by navigating to the login page with the slug as an argument.
  void _handelResetPasswordLink(String token) {
    Get.toNamed(AppRoutes.resetPassword, arguments: {'token': token});
  }
}
