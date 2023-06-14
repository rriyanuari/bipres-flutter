class SiswaModel {
  late String id;
  late String idUser;
  late String namaLengkap;
  late String jenisKelamin;
  late String tanggalLahir;
  late String idTempatLatihan;
  late String idTingkatan;

  SiswaModel({
    required this.id,
    required this.idUser,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.idTempatLatihan,
    required this.idTingkatan,
  });

  SiswaModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    idUser = json["id_user"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
    idTempatLatihan = json["id_tempat_latihan"];
    idTingkatan = json["id_tingkatan"];
  }
}
