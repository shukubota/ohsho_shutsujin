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
                print('onTap');
                rootNavigatorKey.currentState?.pushNamed(Routes.login);
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
