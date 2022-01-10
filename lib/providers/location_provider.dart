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