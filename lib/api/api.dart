class BaseUrl {
  static String url = "https://bipres.holtechno.space/";
  static String paths = "http://192.168.1.9/api-bipres/upload/";

  // AUTH
  static String urlLogin = "${url}api/login.php";
  static String urlUbahPassword = "${url}api/user/edit.php";

  // PROFILE
  static String urlProfile = "${url}api/profile.php";

  // SISWA
  static String urlListSiswa = "${url}api/siswa/list.php";
  static String urlTambahSiswa = "${url}api/siswa/add.php";
  static String urlUbahSiswa = "${url}api/siswa/edit.php";
  static String urlHapusSiswa = "${url}api/siswa/delete.php";

  // PELATIH
  static String urlListPelatih = "${url}api/pelatih/list.php";
  static String urlTambahPelatih = "${url}api/pelatih/add.php";
  static String urlUbahPelatih = "${url}api/pelatih/edit.php";
  static String urlHapusPelatih = "${url}api/pelatih/delete.php";

  // TEMPAT LATIHAN
  static String urlListTempatLatihan = "${url}api/tempat-latihan/list.php";
  static String urlTambahTempatLatihan = "${url}api/tempat-latihan/add.php";
  static String urlUbahTempatLatihan = "${url}api/tempat-latihan/edit.php";
  static String urlHapusTempatLatihan = "${url}api/tempat-latihan/delete.php";

  // TINGKATAN
  static String urlListTingkatan = "${url}api/tingkatan/list.php";

  // SPP
  static String urlListSpp = "${url}api/spp/list.php";
  static String urlTambahSpp = "${url}api/spp/add.php";
  static String urlUbahSpp = "${url}api/spp/edit.php";
  static String urlHapusSpp = "${url}api/spp/delete.php";

  // LOG ABSEN
  static String urlListLogAbsen = "${url}api/absensi/list-log.php";
}
