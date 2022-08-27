import 'package:collection/src/iterable_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ohsho_shutsujin/model/koma.dart';
import 'package:ohsho_shutsujin/pages/panel.dart';

final komaMapProvider = StateNotifierProvider<KomaMapController, KomaMap>((ref) => KomaMapController());

final ohsho = Koma(id: 1, komaType: KomaType.ohsho, point: Point(x: 0, y: 0), title: "王");
final kin = Koma(id: 2, komaType: KomaType.kin, point: Point(x: 2, y: 2), title: "金");
final List<Koma> initialKomaList = [
  ohsho,
  kin,
];

class KomaMap {
  final List<Koma> komaList;
  KomaMap({ required this.komaList });

  bool canToRight(Koma koma) {
    print(koma.point.x);
    print(koma.point.y);
    print("point=======");
    // 境界値チェック
    if (koma.point.x + koma.width >= panelCountX) {
      return false;
    }

    final filledPointList = getFilledPointList();
    // 右が空いているかチェック
    for (int i = 0; i < koma.height; i++) {
      final destination = Point(x: koma.point.x + koma.width, y: koma.point.y);
      // 行き先候補が埋まっていればfalseを返す
      final existing = filledPointList.firstWhereOrNull((e) => e.isEqual(destination));
      if (existing != null) {
        return false;
      }
    }
    return true;
  }

  List<Point> getFilledPointList() {
    var _filledPointList = <Point>[];
    for (int i = 0; i < komaList.length; i++) {
      final Koma koma = komaList[i];
      final pointList = koma.getPointList();
      for (int j = 0; j < pointList.length; j++) {
        final point = pointList[j];
        final existing = _filledPointList.firstWhereOrNull((e) => e.isEqual(point));
        if (existing != null) {
          _filledPointList.add(point);
        }
      }
    }
    return _filledPointList;
  }
}

// コマの配置を管理する
class KomaMapController extends StateNotifier<KomaMap> {
  KomaMapController(): super(KomaMap(komaList: initialKomaList));

  void changeKomaPointToRight(Koma koma) {
    final point = koma.point;

    // 空いているか&壁でないか
    final canToRight = state.canToRight(koma);
    print(canToRight);
    print('========cantoright');
    if (!canToRight) {
      return;
    }
    final newPoint = Point(x: point.x + 1, y: point.y);
    final newKomaList = [
      for (final currentKoma in state.komaList)
        if (koma.id == currentKoma.id)
          Koma(id: koma.id, komaType: koma.komaType, title: koma.title, point: newPoint)
        else
          currentKoma,
    ];
    state = KomaMap(komaList: newKomaList);
  }
}

// x: 0-3
// y: 0-4
class Location {
  int x = 0;
  int y = 0;
  Location({ x, y }) {
    this.x = x ?? 0;
    this.y = x ?? 0;
  }
}

class KomaLocations {
  Location ohsho = Location();
  Location kinsho1 = Location();
  Location kinsho2 = Location();
  Location ginsho = Location();
  Location hisha = Location();
  Location kaku = Location();
  Location fu1 = Location();
  Location fu2 = Location();
  Location keima = Location();
  Location kyosha = Location();

  KomaLocations({
    ohsho,
    kinsho1,
    kinsho2,
    ginsho,
    hisha,
    kaku,
    fu1,
    fu2,
    keima,
    kyosha,
  }) {
    this.ohsho = ohsho;
    this.kinsho1 = kinsho1;
    this.kinsho2 = kinsho2;
    this.ginsho = ginsho;
    this.hisha = hisha;
    this.kaku = kaku;
    this.fu1 = fu1;
    this.fu2 = fu2;
    this.keima = keima;
    this.kyosha = kyosha;
  }
}