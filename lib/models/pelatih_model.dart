class PelatihModel {
  late String id;
  late String idUser;
  late String namaDepan;
  late String namaBelakang;
  late String namaLengkap;
  late String jenisKelamin;
  late String tanggalLahir;
  late String tahunPengesahan;
  late String idTempatLatihan;
  String? TempatLatihan;
  String? username;

  PelatihModel(
      {required this.id,
      required this.idUser,
      required this.namaDepan,
      required this.namaBelakang,
      required this.namaLengkap,
      required this.jenisKelamin,
      required this.tanggalLahir,
      required this.tahunPengesahan,
      required this.idTempatLatihan,
      required this.TempatLatihan,
      this.username});

  PelatihModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    idUser = json["id_user"];
    namaDepan = json["nama_depan"];
    namaBelakang = json["nama_belakang"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
    tahunPengesahan = json["tahun_pengesahan"];
    idTempatLatihan = json["id_tempat_latihan"];
    TempatLatihan =
        (json["tempat_latihan"] != null) ? json["tempat_latihan"] : '';
    username = (json["username"] != null) ? json["username"] : '';
  }
}
