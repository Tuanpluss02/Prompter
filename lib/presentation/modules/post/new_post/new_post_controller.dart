import 'package:base/presentation/base/base_controller.dart';

enum NewPostAction {
  text,
  image,
  link,
  hastag,
  mention,
}

class NewPostController extends BaseController {
  final NewPostAction action;

  NewPostController({required this.action});
}
