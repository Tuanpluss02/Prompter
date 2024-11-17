import 'package:base/common/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseScreen<T extends GetxController> extends GetView<T> {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!vm.initialized) {
      initController();
    }

    return GestureDetector(
      onTap: () {
        opTapScreen.call();
      },
      child: Container(
        color: unSafeAreaColor,
        child: wrapWithSafeArea
            ? SafeArea(
                top: setTopSafeArea,
                bottom: setBottomSafeArea,
                child: _buildScaffold(context),
              )
            : _buildScaffold(context),
      ),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildScreen(context),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  @protected
  Widget buildScreen(BuildContext context);

  @protected
  Widget? buildFloatingActionButton() => null;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => FloatingActionButtonLocation.centerDocked;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  Color? get unSafeAreaColor => AppColors.backgroundColor;

  @protected
  Color? get screenBackgroundColor => AppColors.backgroundColor;

  @protected
  bool get resizeToAvoidBottomInset => false;

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  bool get wrapWithSafeArea => false;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @protected
  Function() get opTapScreen => () {};

  @protected
  Key? get keyScaffold => null;

  void initController() {
    vm.initialized;
  }

  @protected
  T get vm => controller;
}
