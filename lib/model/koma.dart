
class Koma {
  int width = 0;
  int height = 0;
  // 左下のマスの座標(x, y)のminをpositionとする
  Point point = Point(x: 0, y: 0);
  Koma({required KomaType komaType, required Point point}) {
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
    point = point;
  }
  // そのコマが埋めている座標のlist(height * width分ある)
  List<Point> getPointList() {
    final pointList = <Point>[];
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        pointList.add(Point(x: j, y: i));
      }
    }
    return pointList;
  }
}

// 座標を表すclass
class Point {
  int x = 0;
  int y = 0;
  Point({ required this.x, required this.y });
  isEqual(Point point) {
    return x == point.x && y == point.y;
  }
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