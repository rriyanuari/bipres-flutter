class TempatLatihanModel {
  late String id;
  late String tempatLatihan;

  TempatLatihanModel({
    required this.id,
    required this.tempatLatihan,
  });

  TempatLatihanModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tempatLatihan = json["tempat_latihan"];
  }
}
