import 'package:base/presentation/base/base_screen.dart';
import 'package:flutter/material.dart';

import 'new_post_controller.dart';

class NewPostScreen extends BaseScreen<NewPostController> {
  const NewPostScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Center(
      child: Text('New Post Screen${controller.action}'),
    );
  }
}
