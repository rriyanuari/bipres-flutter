class AbsenModel {
  late String id;
  late String tanggal_pertemuan;
  late String pin_absen;
  late String tempat_latihan;
  late List<LogAbsenModel> logAbsen;

  AbsenModel({
    required this.id,
    required this.tanggal_pertemuan,
    required this.pin_absen,
    required this.tempat_latihan,
    required this.logAbsen,
  });

  AbsenModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tanggal_pertemuan = json["tanggal_pertemuan"];
    pin_absen = json["pin_absen"];
    tempat_latihan = json["tempat_latihan"];
    logAbsen = List<LogAbsenModel>.from(
        json["log_absen"].map((x) => LogAbsenModel.fromJson(x)));
  }
}

class LogAbsenModel {
  late String nama_lengkap;
  late DateTime log_time;

  LogAbsenModel({
    required this.nama_lengkap,
    required this.log_time,
  });

  LogAbsenModel.fromJson(Map<String, dynamic> json) {
    nama_lengkap = json["nama_lengkap"];
    log_time = DateTime.parse(json["log_time"]);
  }
}
