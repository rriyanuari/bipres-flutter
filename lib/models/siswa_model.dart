class SiswaModel {
  late String id;
  late String idUser;
  late String namaDepan;
  late String namaBelakang;
  late String namaLengkap;
  late String jenisKelamin;
  late String tanggalLahir;
  late String idTempatLatihan;
  late String idTingkatan;
  late String tempatLatihan;
  late String sabuk;
  String? username;
  var NilaiFisik;
  var Tingkatan;
  var Tes;

  SiswaModel({
    required this.id,
    required this.idUser,
    required this.namaDepan,
    required this.namaBelakang,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.idTempatLatihan,
    required this.idTingkatan,
    required this.tempatLatihan,
    required this.sabuk,
    this.username,
    this.NilaiFisik,
    this.Tingkatan,
    this.Tes,
  });

  SiswaModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    idUser = json["id_user"];
    namaDepan = json["nama_depan"];
    namaBelakang = json["nama_belakang"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
    idTempatLatihan = json["id_tempat_latihan"];
    idTingkatan = json["id_tingkatan"];
    tempatLatihan = json["tempat_latihan"];
    sabuk = json["sabuk"];
    username = json["username"];
    NilaiFisik = (json["nilai_fisik"] != '') ? (json["nilai_fisik"]) : "";
    Tingkatan = (json["tingkatan"] != null) ? (json["tingkatan"]) : [];
    Tes = (json["tes"] != null) ? (json["tes"]) : [];
  }
}
