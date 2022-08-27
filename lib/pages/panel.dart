import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ohsho_shutsujin/model/koma.dart';
import 'package:ohsho_shutsujin/providers/location_provider.dart';
import 'package:ohsho_shutsujin/service/map.dart';
import 'package:ohsho_shutsujin/widgets/koma_view.dart';

import '../main.dart';

const double pieceSize = 60;

const int panelCountX = 4;
const int panelCountY = 5;
const double panelWidth = pieceSize * panelCountX;
const double panelHeight = pieceSize * panelCountY;

// コマのlocation情報を管理する
final mapService = MapService();

class Panel extends ConsumerWidget {
  Panel({Key? key}) : super(key: key);
  // var ohsho = Koma(komaType: KomaType.ohsho, point: Point(x: 0, y: 0), title: "王");
  // final kin = Koma(komaType: KomaType.kin, point: Point(x: 2, y: 2), title: "金");


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    KomaMap komaMap = ref.watch(komaMapProvider);

    print(komaMap.komaList);

    void toRight(Koma koma) {
      ref.read(komaMapProvider.notifier).changeKomaPointToRight(koma);
    }

    void toLeft(Koma koma) {
      ref.read(komaMapProvider.notifier).changeKomaPointToLeft(koma);
    }

    void up(Koma koma) {
      ref.read(komaMapProvider.notifier).changeKomaPointUp(koma);
    }
    void down(Koma koma) {
      ref.read(komaMapProvider.notifier).changeKomaPointDown(koma);
    }

    return Container(
      color: Colors.blue,
      child: Stack(
        children: [
          Container(
            width: panelWidth,
            height: panelHeight,
            color: Colors.grey,
            // child: GestureDetector(
            //   onHorizontalDragEnd: (DragEndDetails point) {
            //     print('end');
            //     print(point.velocity.pixelsPerSecond.dx);
            //     print(point.velocity);
            //     // dynamic transitionFunction = () => {};
            //     if (point.velocity.pixelsPerSecond.dx > 0.0) {
            //       rootNavigatorKey.currentState
            //           ?.pushReplacement(_transit(TransitionType.fromLeft));
            //     } else if (point.velocity.pixelsPerSecond.dx < 0.0) {
            //       rootNavigatorKey.currentState
            //           ?.pushReplacement(_transit(TransitionType.fromRight));
            //     }
            //     // 0の時は何もしない
            //   },
            // ),
          ),
          // ohsho
          KomaView(
            koma: komaMap.komaList[0],
            toRight: toRight,
            toLeft: toLeft,
            up: up,
            down: down,
          ),
          KomaView(
            koma: komaMap.komaList[1],
            toRight: toRight,
            toLeft: toLeft,
            up: up,
            down: down,
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
