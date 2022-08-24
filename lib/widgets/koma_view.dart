import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ohsho_shutsujin/model/koma.dart';
import 'package:ohsho_shutsujin/pages/panel.dart';

class KomaView extends HookWidget {
  late Koma koma;
  KomaView({ Key? key, required Koma koma}) {
    this.koma = koma;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: pieceSize * koma.width,
      height: pieceSize * koma.height,
      margin: const EdgeInsets.fromLTRB(pieceSize * 1.0, 0.0, 0, pieceSize * 0.0),
      // padding: EdgeInsets.fromLTRB(koma.point.x.toDouble(), 0, 0, koma.point.y.toDouble()),
      color: Colors.redAccent,
      child: const Text("金"),
    );
  }
}