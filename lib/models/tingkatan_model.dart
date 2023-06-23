class TingkatanModel {
  late String id;
  late String sabuk;
  late String min_nilai_fisik;
  late String sikap_pasang_4;
  late String sikap_pasang_8;
  late String jurus_tangan_kosong;
  late String jurus_senjata_golok;
  late String jurus_senjata_toya;

  TingkatanModel({
    required this.id,
    required this.sabuk,
    required this.min_nilai_fisik,
    required this.sikap_pasang_4,
    required this.sikap_pasang_8,
    required this.jurus_tangan_kosong,
    required this.jurus_senjata_golok,
    required this.jurus_senjata_toya,
  });

  TingkatanModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    sabuk = json["sabuk"];
    min_nilai_fisik = json["min_nilai_fisik"];
    sikap_pasang_4 = json["sikap_pasang_4"];
    sikap_pasang_8 = json["sikap_pasang_8"];
    jurus_tangan_kosong = json["jurus_tangan_kosong"];
    jurus_senjata_golok = json["jurus_senjata_golok"];
    jurus_senjata_toya = json["jurus_senjata_toya"];
  }
}
