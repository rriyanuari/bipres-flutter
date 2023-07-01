class PelatihModel {
  late String id;
  late String idUser;
  late String namaLengkap;
  late String jenisKelamin;
  late String tanggalLahir;
  late String tahunPengesahan;
  late String idTempatLatihan;
  late String TempatLatihan;

  PelatihModel({
    required this.id,
    required this.idUser,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.tahunPengesahan,
    required this.idTempatLatihan,
    required this.TempatLatihan,
  });

  PelatihModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    idUser = json["id_user"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
    tahunPengesahan = json["tahun_pengesahan"];
    idTempatLatihan = json["id_tempat_latihan"];
    TempatLatihan = json["tempat_latihan"];
  }
}
