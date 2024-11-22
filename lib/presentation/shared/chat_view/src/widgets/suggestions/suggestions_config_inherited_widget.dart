import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:flutter/material.dart';

/// This widget for alternative of excessive amount of passing arguments
/// over widgets.
class SuggestionsConfigIW extends InheritedWidget {
  final ReplySuggestionsConfig? suggestionsConfig;

  const SuggestionsConfigIW({
    super.key,
    required super.child,
    this.suggestionsConfig,
  });

  @override
  bool updateShouldNotify(covariant SuggestionsConfigIW oldWidget) => false;

  static SuggestionsConfigIW? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<SuggestionsConfigIW>();
}
