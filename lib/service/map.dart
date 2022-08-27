import 'package:ohsho_shutsujin/model/koma.dart';
import 'package:collection/collection.dart';

const mapHeight = 5;
const mapWidth = 4;

class MapService {
  // komaオブジェクトのlist
  List<Koma> komaList = [];
  MapService() {
    // filledPointList = [];
  }

  init() {
    // final ohsho = Koma(komaType: KomaType.ohsho);
    // final kin = Koma(komaType: KomaType.kin);
    // addKoma(ohsho);
    // addKoma(kin);
  }

  addKoma(Koma koma) {
    // 位置が空いているかを確かめる コマの座標がすでに指定されていてvalidateする
    final addPointList = koma.getPointList();
    final filledPointList = getFilledPointList();
    for (int i = 0; i < addPointList.length; i++) {
      final addPoint = addPointList[i];
      final isFilled = filledPointList.firstWhereOrNull((element) => element.isEqual(addPoint));
      // すでにその座標が埋まっていればerror
      if (isFilled != null) {
        throw Error();
      }
    }
    komaList = [...komaList, koma];
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
