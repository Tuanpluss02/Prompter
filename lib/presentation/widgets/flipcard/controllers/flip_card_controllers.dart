import '../view/flip_card.dart';

///This controller used to call Fliping
class FlipCardController {
  FlipCardState? state;

  /// Flip the card
  Future flipcard() async => state?.flipCard();
}
