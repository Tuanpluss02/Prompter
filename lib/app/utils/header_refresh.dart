import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HeaderRefresh {
  static ClassicHeader classicHeader = const ClassicHeader(
    refreshingText: 'Đang làm mới...',
    releaseText: 'Thả ra để làm mới',
    completeText: '',
    idleText: 'Kéo xuống để làm mới',
    completeIcon: SizedBox.shrink(),
  );

  static ClassicFooter classicFooter = const ClassicFooter(
    canLoadingText: 'Thả ra để tải thêm',
    loadingText: 'Đang tải thêm dữ liệu...',
    idleText: 'Kéo lên để tải thêm dữ liệu',
    noDataText: 'Không còn dữ liệu .',
  );
}