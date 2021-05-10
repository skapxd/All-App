class ListModelImageUrls {
  List<_ModelImageUrls> items = [];

  ListModelImageUrls();

  ListModelImageUrls.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final modelImageUrls = new _ModelImageUrls.fromJsonMap(item);
      items.add(modelImageUrls);
    }
  }
}

class _ModelImageUrls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  _ModelImageUrls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  _ModelImageUrls.fromJsonMap(Map<String, dynamic> json) {
    raw = json['urls']['raw'];
    full = json['urls']['full'];
    regular = json['urls']['regular'];
    small = json['urls']['small'];
    thumb = json['urls']['thumb'];
  }
}
