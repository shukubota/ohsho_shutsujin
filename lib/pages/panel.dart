import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.dart';

const double pieceSize = 60;

class Panel extends HookWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
        children: [
          Container(
            width: pieceSize * 4,
            height: pieceSize * 5,
            color: Colors.grey,
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails point) {
                print('end');
                print(point.velocity.pixelsPerSecond.dx);
                print(point.velocity);
                // dynamic transitionFunction = () => {};
                if (point.velocity.pixelsPerSecond.dx > 0.0) {
                  rootNavigatorKey.currentState
                      ?.pushReplacement(_transit(TransitionType.fromLeft));
                } else if (point.velocity.pixelsPerSecond.dx < 0.0) {
                  rootNavigatorKey.currentState
                      ?.pushReplacement(_transit(TransitionType.fromRight));
                }
                // 0の時は何もしない
              },
            ),
          ),
          Container(
            width: pieceSize,
            height: pieceSize * 2,
            color: Colors.blueAccent,
          ),
          Container(
            margin: const EdgeInsets.only(left: pieceSize),
            width: pieceSize,
            height: pieceSize * 2,
            color: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }
}

Route _transit(String transitionType) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const Home(text: 'a'),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final double offsetX =
          transitionType == TransitionType.fromLeft ? -1.0 : 1.0;
      final begin = Offset(offsetX, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
