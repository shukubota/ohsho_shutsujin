
class Koma {
  int id;
  int width = 0;
  int height = 0;
  KomaType komaType = KomaType.ohsho;

  String title = "";
  // 左下のマスの座標(x, y)のminをpositionとする
  Point point = Point(x: 0, y: 0);
  Koma({required KomaType komaType, required this.point, required this.title, required this.id}) {
    this.komaType = komaType;
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

  // そのコマが埋めている座標のlist(height * width分ある)
  List<Point> getPointList() {
    final originPoint = point;
    final pointList = <Point>[];
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        pointList.add(Point(x: originPoint.x + j, y: originPoint.y + i));
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