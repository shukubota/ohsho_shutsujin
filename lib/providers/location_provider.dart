import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ohsho_shutsujin/model/koma.dart';

final komaMapProvider = StateNotifierProvider<KomaMapController, List<Koma>>((ref) => KomaMapController());

final ohsho = Koma(id: 1, komaType: KomaType.ohsho, point: Point(x: 0, y: 0), title: "王");
final kin = Koma(id: 2, komaType: KomaType.kin, point: Point(x: 2, y: 2), title: "金");
final List<Koma> initialKomaList = [
  ohsho,
  kin,
];

// コマの配置を管理する
class KomaMapController extends StateNotifier<List<Koma>> {
  KomaMapController(): super(initialKomaList);

  void changeKomaPointToRight(Koma koma) {
    final point = koma.point;
    final newPoint = Point(x: point.x + 1, y: point.y);

    print(koma.height);
    print(koma.width);
    print("------9999");
    print(koma.komaType);
    print(koma.title);
    print(koma.id);
    print(state[0].id);
    print(koma.id == state[0].id);
    print(state[1].id);
    print("------9999");
    state = [
      for (final currentKoma in state)
        if (koma.id == currentKoma.id)
          Koma(id: koma.id, komaType: koma.komaType, title: koma.title, point: newPoint)
        else
          currentKoma,
    ];
    print(state);
    print(state[0].title);
    print(state[1].title);
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