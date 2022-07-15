class AthletesModel {
  String? id_user ;
  String? username;
  String? password;
  String? email;
  String? status;
  String? nama_lengkap;
  String? jenis_kelamin;
  String? tanggal_lahir;
  String? id_sekolah;
  String? log_datetime;

  AthletesModel(
    this.id_user ,
    this.username,
    this.password,
    this.email,
    this.status,
    this.nama_lengkap,
    this.jenis_kelamin,
    this.tanggal_lahir,
    this.id_sekolah,
    this.log_datetime,
  );

  AthletesModel.fromJson(Map<String, dynamic> json) {
    id_user  = json["id_user "];
    username = json["username"];
    password = json["password"];
    email = json["email"];
    status = json["status"];
    nama_lengkap = json["nama_lengkap"];
    jenis_kelamin = json["jenis_kelamin"];
    tanggal_lahir = json["tanggal_lahir"];
    id_sekolah = json["id_sekolah"];
    log_datetime = json["log_datetime"];
  }
}
