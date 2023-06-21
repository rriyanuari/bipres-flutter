class SppModel {
  late String id;
  late String tahun_periode;
  late String total_tagihan;

  SppModel({
    required this.id,
    required this.tahun_periode,
    required this.total_tagihan,
  });

  SppModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tahun_periode = json["tahun_periode"];
    total_tagihan = json["total_tagihan"];
  }
}
