import 'package:get/get.dart';

import '{{page_name.snakeCase()}}_controller.dart';

class {{page_name.pascalCase()}}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => {{page_name.pascalCase()}}Controller());
  }
}