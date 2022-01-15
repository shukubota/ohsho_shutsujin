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
              onTap: () {
                print('onTapa');
                rootNavigatorKey.currentState
                    ?.pushReplacement(_transit(TransitionType.fromLeft));
                ;
                // rootNavigatorKey.currentState?.pushNamed(Routes.login);
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

Route _transit(String type) {
  print(type);
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const Home(text: 'a'),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
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
