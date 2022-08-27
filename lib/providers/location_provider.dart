import 'package:collection/src/iterable_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ohsho_shutsujin/model/koma.dart';
import 'package:ohsho_shutsujin/pages/panel.dart';

final komaMapProvider = StateNotifierProvider<KomaMapController, KomaMap>((ref) => KomaMapController());
final clearStatusProvider = StateNotifierProvider<ClearStatusController, bool>((ref) => ClearStatusController());

// 初期設定　ココは整合性チェックをしていない
final ohsho = Koma(id: 1, komaType: KomaType.ohsho, point: Point(x: 1, y: 0), title: "王");
final kin1 = Koma(id: 2, komaType: KomaType.kin, point: Point(x: 0, y: 0), title: "金");
final kin2 = Koma(id: 3, komaType: KomaType.kin, point: Point(x: 3, y: 0), title: "金");
final gin = Koma(id: 4, komaType: KomaType.gin, point: Point(x: 1, y: 2), title: "銀");
final hisha = Koma(id: 5, komaType: KomaType.hisha, point: Point(x: 3, y: 2), title: "飛");
final kaku = Koma(id: 6, komaType: KomaType.kaku, point: Point(x: 0, y: 2), title: "角");
final kyosha = Koma(id: 7, komaType: KomaType.kyosha, point: Point(x: 2, y: 3), title: "香");
final keima = Koma(id: 8, komaType: KomaType.keima, point: Point(x: 1, y: 3), title: "桂");
final fu1 = Koma(id: 9, komaType: KomaType.fu, point: Point(x: 0, y: 4), title: "歩");
final fu2 = Koma(id: 10, komaType: KomaType.fu, point: Point(x: 3, y: 4), title: "歩");

final List<Koma> initialKomaList = [
  ohsho,
  kin1,
  kin2,
  // gin,
  // hisha,
  // kaku,
  // kyosha,
  // keima,
  fu1,
  fu2,
];

// 本当はdomain層相当の場所へ
class KomaMap {
  final List<Koma> komaList;
  KomaMap({ required this.komaList });

  Koma getOhsho() {
    final ohsho = komaList.firstWhereOrNull((e) => e.komaType == KomaType.ohsho);
    if (ohsho == null) {
      throw Error();
    }
    return ohsho;
  }

  bool checkGameClear() {
    final ohshoGoalPoint = Point(x: 1, y: 3);
    final ohsho = getOhsho();
    if (ohsho.point.isEqual(ohshoGoalPoint)) {
      return true;
    }
    return false;
  }


  bool canToRight(Koma koma) {
    // 境界値チェック
    if (koma.point.x + koma.width >= panelCountX) {
      return false;
    }

    final filledPointList = getFilledPointList();
    // 右が空いているかチェック
    for (int i = 0; i < koma.height; i++) {
      final destination = Point(x: koma.point.x + koma.width, y: koma.point.y + i);
      // 行き先候補が埋まっていればfalseを返す
      final existing = filledPointList.firstWhereOrNull((e) => e.isEqual(destination));
      if (existing != null) {
        return false;
      }
    }
    return true;
  }

  bool canToLeft(Koma koma) {
    // 境界値チェック
    if (koma.point.x <= 0) {
      return false;
    }

    final filledPointList = getFilledPointList();
    // 右が空いているかチェック
    for (int i = 0; i < koma.height; i++) {
      final destination = Point(x: koma.point.x - 1, y: koma.point.y + i);
      // 行き先候補が埋まっていればfalseを返す
      final existing = filledPointList.firstWhereOrNull((e) => e.isEqual(destination));
      if (existing != null) {
        return false;
      }
    }
    return true;
  }

  bool canUp(Koma koma) {
    // 境界値チェック
    if (koma.point.y + koma.height >= panelCountY) {
      return false;
    }
    final filledPointList = getFilledPointList();
    // 上が空いているかチェック
    for (int i = 0; i < koma.width; i++) {
      final destination = Point(x: koma.point.x + i, y: koma.point.y + koma.height);
      print("destination");
      print(destination.x);
      print(destination.y);
      // 行き先候補が埋まっていればfalseを返す
      final existing = filledPointList.firstWhereOrNull((e) => e.isEqual(destination));
      if (existing != null) {
        return false;
      }
    }
    return true;
  }

  bool canDown(Koma koma) {
    // 境界値チェック
    if (koma.point.y <= 0) {
      return false;
    }
    final filledPointList = getFilledPointList();
    // 上が空いているかチェック
    for (int i = 0; i < koma.width; i++) {
      final destination = Point(x: koma.point.x + i, y: koma.point.y - 1);
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
        if (existing == null) {
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

  void init() {
    state = KomaMap(komaList: initialKomaList);
  }

  void changeKomaPointToRight(Koma koma) {
    final point = koma.point;

    // 空いているか&壁でないか
    if (!state.canToRight(koma)) {
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

  void changeKomaPointToLeft(Koma koma) {
    final point = koma.point;

    // 空いているか&壁でないか
    if (!state.canToLeft(koma)) {
      return;
    }
    final newPoint = Point(x: point.x - 1, y: point.y);
    final newKomaList = [
      for (final currentKoma in state.komaList)
        if (koma.id == currentKoma.id)
          Koma(id: koma.id, komaType: koma.komaType, title: koma.title, point: newPoint)
        else
          currentKoma,
    ];
    state = KomaMap(komaList: newKomaList);
  }

  void changeKomaPointUp(Koma koma) {
    final point = koma.point;

    // クリア条件を満たしていればクリア
    if (state.checkGameClear()) {
      return;
    }

    // 空いているか&壁でないか
    if (!state.canUp(koma)) {
      return;
    }
    final newPoint = Point(x: point.x, y: point.y + 1);
    final newKomaList = [
      for (final currentKoma in state.komaList)
        if (koma.id == currentKoma.id)
          Koma(id: koma.id, komaType: koma.komaType, title: koma.title, point: newPoint)
        else
          currentKoma,
    ];
    state = KomaMap(komaList: newKomaList);
  }

  void changeKomaPointDown(Koma koma) {
    final point = koma.point;

    // 空いているか&壁でないか
    if (!state.canDown(koma)) {
      return;
    }
    final newPoint = Point(x: point.x, y: point.y - 1);
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

// clearしたかどうか
class ClearStatusController extends StateNotifier<bool> {
  ClearStatusController(): super(false);
  void clearGame() {
    state = true;
  }
  void init() {
    state = false;
  }
}


// 以下必要か確認必要
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