// Define transition-related classes
import 'dart:ui';

enum TransitionType { circularReveal, toTheTop, slide, fade }

class TransitionConfig {
  final TransitionType transitionType;
  final Offset? tapPosition;

  /// [transitionType] Type of transition want: [TransitionType.fade] by default
  ///
  /// [tapPosition] Position of the tap: [null] by default
  /// in case null, it will be set to the center of the screen
  /// only provide this, is [transitionType] is [TransitionType.circularReveal]
  TransitionConfig({
    this.transitionType = TransitionType.fade,
    this.tapPosition,
  });
}
