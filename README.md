TODO: add context menu to post, comment, message

## Folder Structure

```plaintext
lib/
├── app_provider.dart
├── common/
│   ├── app_links/
│   │   ├── app_links_handler.dart
│   │   └── ...
│   ├── config/
│   │   ├── app_binding.dart
│   │   └── ...
│   ├── constants/
│   │   ├── app_assets_path.dart
│   │   └── ...
│   ├── localization/
│   │   ├── locale_keys.g.dart
│   │   └── ...
│   ├── utils/
│   │   ├── app_haptics.dart
│   │   └── ...
│   └── ...
├── dependency_injection.dart
├── domain/
│   ├── data/
│   │   ├── entities/
│   │   │   ├── ai_image_entity.dart
│   │   │   └── ...
│   │   ├── local/
│   │   │   ├── api_error.dart
│   │   │   └── ...
│   │   ├── page_data/
│   │   │   ├── new_post_page_data.dart
│   │   │   └── ...
│   │   ├── responses/
│   │   │   ├── base_response.dart
│   │   │   └── ...
│   │   └── ...
│   ├── repositories/
│   │   ├── ai_image_repository.dart
│   │   └── ...
│   ├── services/
│   │   ├── auth_service.dart
│   │   └── ...
│   └── ...
├── firebase_options.dart
├── main.dart
├── presentation/
│   ├── base/
│   │   ├── base_controller.dart
│   │   └── ...
│   ├── modules/
│   │   ├── account/
│   │   │   ├── account_binding.dart
│   │   │   └── ...
│   │   ├── ai_chat/
│   │   │   ├── ai_chat_binding.dart
│   │   │   └── ...
│   │   ├── authentication/
│   │   │   ├── forgot_password/
│   │   │   │   ├── forgot_password_binding.dart
│   │   │   │   └── ...
│   │   │   ├── login/
│   │   │   │   ├── login_binding.dart
│   │   │   │   └── ...
│   │   │   └── ...
│   │   ├── home/
│   │   │   ├── comment/
│   │   │   │   ├── comment_binding.dart
│   │   │   │   └── ...
│   │   │   ├── components/
│   │   │   │   ├── comment_section.dart
│   │   │   │   └── ...
│   │   │   ├── home_binding.dart
│   │   │   └── ...
│   │   ├── photo_gallery/
│   │   │   ├── components/
│   │   │   │   ├── photo_gallery_grid.dart
│   │   │   │   └── ...
│   │   │   ├── photo_gallery_binding.dart
│   │   │   └── ...
│   │   ├── preferences/
│   │   │   ├── change_password/
│   │   │   │   ├── change_password_binding.dart
│   │   │   │   └── ...
│   │   │   ├── change_user_info/
│   │   │   │   ├── change_user_info_binding.dart
│   │   │   │   └── ...
│   │   │   └── ...
│   │   ├── profile/
│   │   │   ├── profile_binding.dart
│   │   │   └── ...
│   │   ├── root/
│   │   │   ├── root_binding.dart
│   │   │   └── ...
│   │   ├── search/
│   │   │   ├── search_binding.dart
│   │   │   └── ...
│   │   ├── splash/
│   │   │   ├── splash_binding.dart
│   │   │   └── ...
│   │   └── ...
│   ├── routes/
│   │   ├── app_middleware.dart
│   │   └── ...
│   ├── shared/
│   │   ├── animated/
│   │   │   ├── animated_progress_bar.dart
│   │   │   └── ...
│   │   ├── chat_view/
│   │   │   ├── chatview.dart
│   │   │   └── ...
│   │   ├── global/
│   │   │   ├── app_back_button.dart
│   │   │   └── ...
│   │   ├── gradient/
│   │   │   ├── gradient_border_button.dart
│   │   │   └── ...
│   │   ├── utils/
│   │   │   ├── full_screen_image_view.dart
│   │   │   └── ...
│   │   └── ...
│   └── ...
└── ...
```
