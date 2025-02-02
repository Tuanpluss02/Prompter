import 'dart:math' as math;

import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/chat_view/src/utils/constants/constants.dart';
import 'package:base/presentation/shared/chat_view/src/widgets/suggestions/suggestion_item.dart';
import 'package:flutter/material.dart';

class SuggestionList extends StatefulWidget {
  const SuggestionList({super.key});

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<SuggestionItemData> suggestions = [];
  bool isSuggestionListEmpty = false;

  @override
  void activate() {
    super.activate();
    final newSuggestions = chatViewIW?.chatController.newSuggestions;
    newSuggestions?.addListener(animateSuggestionList);
  }

  void animateSuggestionList() {
    final newSuggestions = chatViewIW?.chatController.newSuggestions;
    if (newSuggestions != null) {
      isSuggestionListEmpty = newSuggestions.value.isEmpty;
      isSuggestionListEmpty ? _controller.reverse() : _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final suggestionsItemConfig = suggestionsConfig?.itemConfig;
    final suggestionsListConfig = suggestionsConfig?.listConfig ?? const SuggestionListConfig();
    return Container(
      decoration: suggestionsListConfig.decoration,
      padding: suggestionsListConfig.padding ?? const EdgeInsets.only(left: 8.0),
      margin: suggestionsListConfig.margin,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Align(
              alignment: const AlignmentDirectional(-1.0, -1.0),
              heightFactor: math.max(_controller.value, 0.0),
              widthFactor: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: List.generate(
                    suggestions.length,
                    (index) {
                      final suggestion = suggestions[index];
                      return suggestion.config?.customItemBuilder?.call(index, suggestion) ??
                          suggestionsItemConfig?.customItemBuilder?.call(index, suggestion) ??
                          Padding(
                            padding: EdgeInsets.only(
                              right: index == suggestions.length ? 0 : suggestionsListConfig.itemSeparatorWidth,
                            ),
                            child: SuggestionItem(
                              suggestionItemData: suggestion,
                            ),
                          );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void deactivate() {
    final newSuggestions = chatViewIW?.chatController.newSuggestions;
    newSuggestions?.removeListener(animateSuggestionList);
    super.deactivate();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(updateSuggestionsOnAnimation)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: suggestionListAnimationDuration,
      vsync: this,
    )..addListener(updateSuggestionsOnAnimation);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newSuggestions = chatViewIW?.chatController.newSuggestions;
      newSuggestions?.addListener(animateSuggestionList);
    });
  }

  void updateSuggestionsOnAnimation() {
    if (isSuggestionListEmpty && _controller.value == 0) {
      suggestions = [];
    } else if (chatViewIW?.chatController.newSuggestions.value.isNotEmpty ?? false) {
      suggestions = chatViewIW?.chatController.newSuggestions.value ?? [];
    }
  }
}
