class SekolahModel {
  String? id_sekolah ;
  String? nama_sekolah;
  String? jenjang_sekolah;
  String? log_datetime;


  SekolahModel(
    this.id_sekolah ,
    this.nama_sekolah,
    this.jenjang_sekolah,
    this.log_datetime,
  );

  SekolahModel.fromJson(Map<String, dynamic> json) {
    id_sekolah  = json["id_sekolah "];
    nama_sekolah = json["nama_sekolah"];
    jenjang_sekolah = json["jenjang_sekolah"];
    log_datetime = json["log_datetime"];
  }
}
