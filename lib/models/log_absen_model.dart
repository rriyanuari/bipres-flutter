class AbsenModel {
  late String id;
  late String tanggal_pertemuan;
  late String pin_absen;
  late String tempat_latihan;
  late String total_siswa;
  late String total_siswa_absen;
  late List<LogAbsenModel> logAbsen;

  AbsenModel({
    required this.id,
    required this.tanggal_pertemuan,
    required this.pin_absen,
    required this.tempat_latihan,
    required this.total_siswa,
    required this.total_siswa_absen,
    required this.logAbsen,
  });

  AbsenModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tanggal_pertemuan = json["tanggal_pertemuan"];
    pin_absen = json["pin_absen"];
    tempat_latihan = json["tempat_latihan"];
    total_siswa = json["total_siswa"];
    total_siswa_absen = json["total_siswa_absen"];
    logAbsen = List<LogAbsenModel>.from(
        json["log_absen"].map((x) => LogAbsenModel.fromJson(x)));
  }
}

class AbsenSiswaModel {
  late String id;
  late String tanggal_pertemuan;
  late String tempat_latihan;
  late String nama_lengkap;
  late String log_time;

  AbsenSiswaModel({
    required this.id,
    required this.tanggal_pertemuan,
    required this.tempat_latihan,
    required this.nama_lengkap,
    required this.log_time,
  });

  AbsenSiswaModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    tanggal_pertemuan = json["tanggal_pertemuan"];
    tempat_latihan = json["tempat_latihan"];
    nama_lengkap = json["nama_lengkap"];
    log_time = json["log_time"];
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
