import 'package:bipres/UI/admin/pelatih_screen.dart';
import 'package:bipres/UI/admin/pelatih_add_screen.dart';
import 'package:bipres/UI/admin/siswa_screen.dart';
import 'package:bipres/UI/admin/spp_add_screen.dart';
import 'package:bipres/UI/admin/spp_screen.dart';
import 'package:bipres/UI/admin/tempat_latihan_add_screen.dart';
import 'package:bipres/UI/admin/tempat_latihan_screen.dart';
import 'package:bipres/UI/admin/tingkatan_screen.dart';
import 'package:bipres/UI/auth/login_screen.dart';
import 'package:bipres/UI/onBoard_screen.dart';
import 'package:bipres/UI/splash_screen.dart';
import 'package:bipres/UI/admin/siswa_add_screen.dart';
import 'package:bipres/UI/main_user_screen.dart';
import 'package:bipres/routes/route_name.dart';
// import 'package:final_project/UI/login_screen.dart';
// import 'package:final_project/UI/register_screen.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class pageRouteApp {
  static final pages = [
    GetPage(name: RouteName.splash_screen, page: () => SplashScreen()),
    GetPage(name: RouteName.onBoard_screen, page: () => OnBoardScreen()),
    GetPage(name: RouteName.login_screen, page: () => LoginScreen()),
    GetPage(name: RouteName.main_user_screen, page: () => MainUserScreen()),

    // Tingkatan
    GetPage(name: RouteName.tingkatan_screen, page: () => TingkatanScreen()),

    // Siswa
    GetPage(name: RouteName.siswa_screen, page: () => SiswaScreen()),
    GetPage(name: RouteName.siswa_add_screen, page: () => SiswaAddScreen()),

    // Pelatih
    GetPage(name: RouteName.pelatih_screen, page: () => PelatihScreen()),
    GetPage(name: RouteName.pelatih_add_screen, page: () => PelatihAddScreen()),

    // Tempat Latihan
    GetPage(
        name: RouteName.tempat_latihan_screen,
        page: () => TempatLatihanScreen()),
    GetPage(
        name: RouteName.tempat_latihan_add_screen,
        page: () => TempatLatihanAddScreen()),
    // GetPage(
    //     name: RouteName.tempat_latihan_edit_screen,
    //     page: () => TempatLatihanEditScreen()),

    // Spp
    GetPage(name: RouteName.spp_screen, page: () => SppScreen()),
    GetPage(name: RouteName.spp_add_screen, page: () => SppAddScreen()),
  ];
}
