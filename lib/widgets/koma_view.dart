import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ohsho_shutsujin/model/koma.dart';
import 'package:ohsho_shutsujin/pages/panel.dart';

class KomaView extends HookWidget {
  final Koma koma;
  final Function toRight;
  final Function toLeft;
  final Function up;
  final Function down;
  const KomaView({
    Key? key,
    required this.koma,
    required this.toRight,
    required this.toLeft,
    required this.up,
    required this.down,
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    final double marginFromTop = panelHeight - pieceSize * (koma.height + koma.point.y.toDouble());
    final double marginFromLeft = pieceSize * koma.point.x.toDouble();
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails diff) {
        if (diff.velocity.pixelsPerSecond.dx > 0) {
          toRight(koma);
        } else if (diff.velocity.pixelsPerSecond.dx < 0){
          toLeft(koma);
        }
      },
      onVerticalDragEnd: (DragEndDetails diff) {
        print(diff.velocity.pixelsPerSecond);
        if (diff.velocity.pixelsPerSecond.dy < 0) {
          up(koma);
        } else if (diff.velocity.pixelsPerSecond.dy > 0){
          down(koma);
        }
      },
      child: Container(
        width: pieceSize * koma.width,
        height: pieceSize * koma.height,
        margin: EdgeInsets.fromLTRB(marginFromLeft, marginFromTop, 0, 0),
        color: Colors.blueGrey,
        child: Text(
            koma.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
        ),
      ),
    );
  }
}