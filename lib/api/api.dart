class BaseUrl {
  static String url = "http://192.168.1.9/api-bipres/";
  static String paths = "http://192.168.1.9/api-bipres/upload/";

  // LOGIN
  static String urlLogin = url + "api/login.php";

  // SEKOLAH
  static String urlListSekolah = url + "api/sekolah/list.php";
  static String urlTambahSekolah = url + "api/sekolah/add.php";
  static String urlUbahSekolah = url + "api/sekolah/edit.php";
  static String urlHapusSekolah = url + "api/sekolah/delete.php";

  // KATEGORI STATS
  static String urlListKategoriStats = url + "api/kategori-stats/list.php";
  static String urlTambahKategoriStats = url + "api/kategori-stats/add.php";
  static String urlUbahKategoriStats = url + "api/kategori-stats/edit.php";
  static String urlHapusKategoriStats = url + "api/kategori-stats/delete.php";

  // ATLET
  static String urlListAtlet = url + "api/atlet/list.php";
  static String urlTambahAtlet = url + "api/atlet/add.php";
  static String urlUbahAtlet = url + "api/atlet/edit.php";
  static String urlHapusAtlet = url + "api/atlet/delete.php";
}
