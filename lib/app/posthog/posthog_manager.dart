// import 'package:posthog_flutter/posthog_flutter.dart';

// class PosthogManager {
//   final _posthog = Posthog();

//   PosthogManager();

//   Future<void> identify({
//     required String userId,
//     Map<String, Object>? userProperties,
//     Map<String, Object>? userPropertiesSetOnce,
//   }) async {
//     await _posthog.reset();
//     await _posthog.identify(
//         userId: userId,
//         // cần tìm hiểu thêm về cách dùng 2 tham số này
//         userProperties: userProperties,
//         userPropertiesSetOnce: userPropertiesSetOnce);
//   }

//   Future<void> logEvent({
//     required String eventName,
//     Map<String, Object>? properties,
//   }) async {
//     await _posthog.capture(
//       eventName: eventName,
//       properties: properties,
//     );
//   }

//   /// to reset the user's distinct ID and clear all stored properties
//   Future<void> reset() async {
//     await _posthog.reset();
//   }
// }