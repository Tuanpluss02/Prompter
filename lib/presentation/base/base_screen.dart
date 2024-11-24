import 'package:base/common/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseScreen<T extends GetxController> extends GetView<T> {
  const BaseScreen({super.key});

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => FloatingActionButtonLocation.centerDocked;

  @protected
  Key? get keyScaffold => null;

  @protected
  Function() get opTapScreen => () {};

  @protected
  bool get resizeToAvoidBottomInset => false;

  @protected
  Color? get screenBackgroundColor => AppColors.backgroundColor;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @protected
  Color? get unSafeAreaColor => AppColors.backgroundColor;

  @protected
  T get vm => controller;

  @protected
  bool get wrapWithSafeArea => false;

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

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  Widget? buildFloatingActionButton() => null;

  @protected
  Widget buildScreen(BuildContext context);

  void initController() {
    vm.initialized;
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: GestureDetector(onTap: () => FocusScope.of(context).unfocus(), child: buildScreen(context)),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton(),
    );
  }
}
