class KategoriStatsModel {
  String? id_kategori_stats ;
  String? nama_kategori_stats;
  String? deskripsi_kategori_stats;
  String? log_datetime;


  KategoriStatsModel(
    this.id_kategori_stats ,
    this.nama_kategori_stats,
    this.deskripsi_kategori_stats,
    this.log_datetime,
  );

  KategoriStatsModel.fromJson(Map<String, dynamic> json) {
    id_kategori_stats  = json["id_kategori_stats "];
    nama_kategori_stats = json["nama_kategori_stats"];
    deskripsi_kategori_stats = json["deskripsi_kategori_stats"];
    log_datetime = json["log_datetime"];
  }
}
