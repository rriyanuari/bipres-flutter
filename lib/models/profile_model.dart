class ProfileModel {
  late String idUser;
  late String namaLengkap;
  late String jenisKelamin;
  late String tanggalLahir;
  late String tempatLatihan;
  late String? tahunPengesahan;
  late String? sabuk;
  late String? role;

  ProfileModel({
    required this.idUser,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.tempatLatihan,
    required this.tahunPengesahan,
    required this.sabuk,
    required this.role,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    idUser = json["id_user"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
    tempatLatihan = json["tempat_latihan"];
    tahunPengesahan = json["tahun_pengesahan"];
    sabuk = json["sabuk"];
    role = json["role"];
  }
}
