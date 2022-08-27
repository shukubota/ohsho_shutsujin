import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ohsho_shutsujin/model/koma.dart';
import 'package:ohsho_shutsujin/providers/location_provider.dart';
import 'package:ohsho_shutsujin/service/map.dart';
import 'package:ohsho_shutsujin/widgets/koma_view.dart';

// コマのlocation情報を管理する
final mapService = MapService();

const int panelCountX = 4;
const int panelCountY = 5;

class Panel extends ConsumerWidget {
  Panel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size displaySize = MediaQuery.of(context).size;
    final double pieceSize = (displaySize.width - 100) / 4.0;
    final double panelWidth = pieceSize * panelCountX;
    final double panelHeight = pieceSize * panelCountY;
    KomaMap komaMap = ref.watch(komaMapProvider);
    bool isDisplayClearLabel = ref.watch(clearStatusProvider);

    void toRight(Koma koma) {
      ref.read(komaMapProvider.notifier).changeKomaPointToRight(koma);
    }
    void toLeft(Koma koma) {
      ref.read(komaMapProvider.notifier).changeKomaPointToLeft(koma);
    }
    void up(Koma koma) {
      final isClear = komaMap.checkGameClear();
      if (isClear) {
        ref.read(clearStatusProvider.notifier).clearGame();
      }
      ref.read(komaMapProvider.notifier).changeKomaPointUp(koma);
    }
    void down(Koma koma) {
      ref.read(komaMapProvider.notifier).changeKomaPointDown(koma);
    }

    void fromStart() {
      ref.read(clearStatusProvider.notifier).init();
      ref.read(komaMapProvider.notifier).init();
    }

    void continueGame() {
      ref.read(clearStatusProvider.notifier).init();
    }

    final viewingKomaList = [
      for (final _koma in komaMap.komaList)
        KomaView(
          koma: _koma,
          toRight: toRight,
          toLeft: toLeft,
          up: up,
          down: down,
          pieceSize: pieceSize,
        ),
    ];

    return Container(
      color: Colors.blue,
      child: Stack(
        children: [
          Container(
            width: panelWidth,
            height: panelHeight,
            color: const Color(0xffbaa291),
          ),
          ...viewingKomaList,
          if (isDisplayClearLabel)
            Opacity(
              opacity: 0.7,
              child: Container(
                width: panelWidth,
                height: panelHeight,
                color: Colors.black,
              ),
            ),
          if (isDisplayClearLabel)
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Text(
                    "Game Clear!!",
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    fromStart();
                  },
                  child: const Text(
                    ">最初から",
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    continueGame();
                  },
                  child: const Text(
                    ">続ける",
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
