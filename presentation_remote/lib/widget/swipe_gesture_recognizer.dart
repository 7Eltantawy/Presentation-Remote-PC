//source
//https://pub.dev/packages/swipe_gesture_recognizer
// but with null safety

import 'package:flutter/widgets.dart';

class SwipeGestureRecognizer extends StatefulWidget {
  final Function() onSwipeLeft;
  final Function() onSwipeRight;
  final Function() onSwipeUp;
  final Function() onSwipeDown;
  final Widget? child;
  const SwipeGestureRecognizer({
    Key? key,
    this.child,
    required this.onSwipeDown,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onSwipeUp,
  }) : super(key: key);

  @override
  _SwipeGestureRecognizerState createState() => _SwipeGestureRecognizerState();
}

class _SwipeGestureRecognizerState extends State<SwipeGestureRecognizer> {
  late Offset _horizontalSwipeStartingOffset;
  late Offset _verticalSwipeStartingOffset;

  late bool _isSwipeLeft;
  late bool _isSwipeRight;
  late bool _isSwipeUp;
  late bool _isSwipeDown;

  @override
  void initState() {
    super.initState();
    _horizontalSwipeStartingOffset =
        _horizontalSwipeStartingOffset = Offset.zero;
    _isSwipeDown = _isSwipeUp = _isSwipeRight = _isSwipeLeft = false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return (widget.onSwipeLeft != null || widget.onSwipeRight != null) &&
            // ignore: unnecessary_null_comparison
            (widget.onSwipeDown != null || widget.onSwipeUp != null)
        ? GestureDetector(
            child: widget.child,
            onHorizontalDragStart: (details) {
              _horizontalSwipeStartingOffset = details.localPosition;
            },
            onHorizontalDragUpdate: (details) {
              if (_horizontalSwipeStartingOffset.dx >
                  details.localPosition.dx) {
                _isSwipeLeft = true;
                _isSwipeRight = false;
              } else {
                _isSwipeRight = true;
                _isSwipeLeft = false;
              }
            },
            onHorizontalDragEnd: (details) {
              if (_isSwipeLeft) {
                widget.onSwipeLeft();
              } else if (_isSwipeRight) {
                widget.onSwipeRight();
              }
            },
            onVerticalDragStart: (details) {
              _verticalSwipeStartingOffset = details.localPosition;
            },
            onVerticalDragUpdate: (details) {
              if (_verticalSwipeStartingOffset.dy > details.localPosition.dy) {
                _isSwipeUp = true;
                _isSwipeDown = false;
              } else {
                _isSwipeDown = true;
                _isSwipeUp = false;
              }
            },
            onVerticalDragEnd: (details) {
              if (_isSwipeUp) {
                widget.onSwipeUp();
              } else if (_isSwipeDown) {
                widget.onSwipeDown();
              }
            },
          )
        // ignore: unnecessary_null_comparison
        : (widget.onSwipeLeft != null || widget.onSwipeRight != null)
            ? GestureDetector(
                child: widget.child,
                onHorizontalDragStart: (details) {
                  _horizontalSwipeStartingOffset = details.localPosition;
                },
                onHorizontalDragUpdate: (details) {
                  if (_horizontalSwipeStartingOffset.dx >
                      details.localPosition.dx) {
                    _isSwipeLeft = true;
                    _isSwipeRight = false;
                  } else {
                    _isSwipeRight = true;
                    _isSwipeLeft = false;
                  }
                },
                onHorizontalDragEnd: (details) {
                  // ignore: unnecessary_null_comparison
                  if (_isSwipeLeft && widget.onSwipeLeft != null) {
                    widget.onSwipeLeft();
                    // ignore: unnecessary_null_comparison
                  } else if (_isSwipeRight && widget.onSwipeRight != null) {
                    widget.onSwipeRight();
                  }
                },
              )
            // ignore: unnecessary_null_comparison
            : (widget.onSwipeDown != null || widget.onSwipeUp != null)
                ? GestureDetector(
                    child: widget.child,
                    onVerticalDragStart: (details) {
                      _verticalSwipeStartingOffset = details.localPosition;
                    },
                    onVerticalDragUpdate: (details) {
                      if (_verticalSwipeStartingOffset.dy >
                          details.localPosition.dy) {
                        _isSwipeUp = true;
                        _isSwipeDown = false;
                      } else {
                        _isSwipeDown = true;
                        _isSwipeUp = false;
                      }
                    },
                    onVerticalDragEnd: (details) {
                      if (_isSwipeUp) {
                        widget.onSwipeUp();
                      } else if (_isSwipeDown) {
                        widget.onSwipeDown();
                      }
                    },
                  )
                : const SizedBox.shrink();
  }
}
