class ProfileModel {
  late String idUser;
  late String namaLengkap;
  late String jenisKelamin;
  late String tanggalLahir;
  late String tempatLatihan;
  late String sabuk;

  ProfileModel({
    required this.idUser,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.tempatLatihan,
    required this.sabuk,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    idUser = json["id_user"];
    namaLengkap = json["nama_lengkap"];
    jenisKelamin = json["jenis_kelamin"];
    tanggalLahir = json["tanggal_lahir"];
    tempatLatihan = json["tempat_latihan"];
    sabuk = json["sabuk"];
  }
}
