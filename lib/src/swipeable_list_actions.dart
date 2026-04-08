import 'package:flutter/material.dart';

import 'swipe_action_button.dart';
import 'swipe_direction.dart';
import 'utils/swipe_constants.dart';

class SwipeableListActions extends StatefulWidget {
  final Widget child;
  final List<SwipeActionButton> leftActions;
  final List<SwipeActionButton> rightActions;
  final SwipeDirection direction;

  const SwipeableListActions({
    super.key,
    required this.child,
    this.leftActions = const [],
    this.rightActions = const [],
    this.direction = SwipeDirection.both,
  });
  @override
  State<SwipeableListActions> createState() => _SwipeableListActionsState();
}

class _SwipeableListActionsState extends State<SwipeableListActions> {
  double offset = 0;

  double get leftWidth =>
      widget.leftActions.length * SwipeConstants.actionWidth;

  double get rightWidth =>
      widget.rightActions.length * SwipeConstants.actionWidth;

  void closeActions() {
    setState(() {
      offset = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragUpdate: (details) {
              setState(() {
                offset += details.delta.dx;
                if (offset > leftWidth) {
                  offset = leftWidth;
                }

                if (offset < -rightWidth) {
                  offset = -rightWidth;
                }
              });
            },
            onHorizontalDragEnd: (_) {
              setState(() {
                if (offset > 40) {
                  offset = leftWidth;
                } else if (offset < -40) {
                  offset = -rightWidth;
                } else {
                  offset = 0;
                }
              });
            },
            child: Stack(
                children: [
                if (widget.leftActions.isNotEmpty)
          Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Row(
            children: widget.leftActions.map((action) {
              return SizedBox(
                width: SwipeConstants.actionWidth,
                child: Material(
                  color: action.style.backgroundColor,
                  child: InkWell(
                    onTap: () {
                      action.onTap();
                      closeActions();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          action.icon,
                          color: action.style.foregroundColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          action.label,
                          style: TextStyle(
                            color: action.style.foregroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        if (widget.rightActions.isNotEmpty)
    Positioned(
        right: 0,
        top: 0,
        bottom: 0,
        child: Row(
            children: widget.rightActions.map((action) {
              return SizedBox(
                  width: SwipeConstants.actionWidth,
                  child: Material(
                      color: action.style.backgroundColor,
                      child: InkWell(
                        onTap: () {
                          action.onTap();
                          closeActions();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Icon(
                          action.icon,
                          color: action.style.foregroundColor,
                        ),
                        const SizedBox(height: 4),
                            Text(
                              action.label,
                              style: TextStyle(
                                color: action.style.foregroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
              );
            }).toList(),
        ),
    ),
                  AnimatedPositioned(
                    duration: SwipeConstants.animationDuration,
                    left: offset,
                    right: -offset,
                    top: 0,
                    bottom: 0,
                    child: Material(
                      elevation: offset == 0 ? 0 : 4,
                      child: widget.child,
                    ),
                  ),
                ],
            ),
        ),
    );
  }
}

