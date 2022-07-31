
class Koma {
  int width = 0;
  int height = 0;
  List<Point> area = [];
  Koma({required KomaType komaType}) {
    switch(komaType) {
      case KomaType.ohsho:
        width = 2;
        height = 2;
        break;
      case KomaType.kin:
        width = 1;
        height = 2;
        break;
      case KomaType.gin:
        width = 2;
        height = 1;
        break;
      case KomaType.keima:
        width = 1;
        height = 1;
        break;
      case KomaType.kyosha:
        width = 1;
        height = 1;
        break;
      case KomaType.hisha:
        width = 1;
        height = 2;
        break;
      case KomaType.kaku:
        width = 1;
        height = 2;
        break;
      case KomaType.fu:
        width = 1;
        height = 1;
        break;
      default:
        throw Error();
    }
  }
}

// 座標を表すclass
class Point {
  int x = 0;
  int y = 0;
}

enum KomaType {
  ohsho,
  kin,
  gin,
  keima,
  kyosha,
  kaku,
  hisha,
  fu,
}