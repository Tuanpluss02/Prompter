import 'package:base/app_provider.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final AppProvider appProvider = Get.find<AppProvider>();
  var isLoading = false.obs;
}
