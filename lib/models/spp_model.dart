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

class TransSppModel {
  late String id;
  late String nama_lengkap;
  late String tempat_latihan;
  late List<TransaksiModel> transaksi;

  TransSppModel({
    required this.id,
    required this.nama_lengkap,
    required this.tempat_latihan,
    required this.transaksi,
  });

  TransSppModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nama_lengkap = json["nama_lengkap"];
    tempat_latihan = json["tempat_latihan"];
    transaksi = List<TransaksiModel>.from(
        json["transaksi"].map((x) => TransaksiModel.fromJson(x)));
  }
}

class TransaksiModel {
  late String id;
  late String tahun_periode;
  late String total_tagihan;
  late String tanggal_bayar;
  late String nominal_bayar;

  TransaksiModel({
    required this.id,
    required this.tahun_periode,
    required this.total_tagihan,
    required this.tanggal_bayar,
    required this.nominal_bayar,
  });

  TransaksiModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tahun_periode = json["tahun_periode"];
    total_tagihan = json["total_tagihan"];
    tanggal_bayar = json["tanggal_bayar"];
    nominal_bayar = json["nominal_bayar"];
  }
}
