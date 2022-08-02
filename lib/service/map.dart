import 'package:ohsho_shutsujin/model/koma.dart';

const mapHeight = 5;
const mapWidth = 4;



class MapService {
  // komaオブジェクトのlist
  List<Koma> komaList = [];
  List<Point> emptyPointList = [];
  MapService() {
    final _emptyPointList = <Point>[];
    for (int i = 0; i < mapHeight; i++) {
      for (int j = 0; j < mapWidth; j++) {
        _emptyPointList.add(Point(x: j, y: i));
      }
    }
    emptyPointList = _emptyPointList;
  }

  addKoma(Koma koma) {
    // 位置が空いているかを確かめる コマの座標がすでに指定されていてvalidateする


    komaList.add(koma);
  }

  List<Point> getEmptyPointList() {
    for (int i = 0; i < komaList.length; i++) {
      final Koma koma = komaList[i];
      final pointList = koma.getPointList();
    }
  }

}
