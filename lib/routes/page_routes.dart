import 'package:bipres/UI/admin/laporan_screen.dart';
import 'package:bipres/UI/siswa/tes_kenaikan_detail_screen.dart';
import 'package:bipres/UI/siswa/trans_spp_detail_screen.dart';
import 'package:get/get.dart';

import 'package:bipres/routes/route_name.dart';
import 'package:bipres/UI/main_user_screen.dart';
import 'package:bipres/UI/onBoard_screen.dart';
import 'package:bipres/UI/splash_screen.dart';

import 'package:bipres/UI/auth/login_screen.dart';
import 'package:bipres/UI/auth/ubah_password_screen.dart';

// MASTER DATA SCREEN

import 'package:bipres/UI/admin/pelatih_screen.dart';
import 'package:bipres/UI/admin/pelatih_add_screen.dart';
import 'package:bipres/UI/admin/pelatih_edit_screen.dart';

import 'package:bipres/UI/admin/siswa_screen.dart';
import 'package:bipres/UI/admin/siswa_add_screen.dart';

import 'package:bipres/UI/admin/spp_screen.dart';
import 'package:bipres/UI/admin/spp_add_screen.dart';

import 'package:bipres/UI/admin/tempat_latihan_screen.dart';
import 'package:bipres/UI/admin/tempat_latihan_add_screen.dart';

import 'package:bipres/UI/admin/tingkatan_screen.dart';

// END MASTER DATA SCREEN

import 'package:bipres/UI/admin/trans_spp_screen.dart';
import 'package:bipres/UI/admin/trans_spp_detail_screen.dart';
import 'package:bipres/UI/admin/trans_spp_add_screen.dart';

import 'package:bipres/UI/admin/absen_screen.dart';
import 'package:bipres/UI/admin/absen_add_screen.dart';
import 'package:bipres/UI/admin/absen_detail_screen.dart';

import 'package:bipres/UI/siswa/absen_screen.dart';

import 'package:bipres/UI/admin/tes_kenaikan_screen.dart';
import 'package:bipres/UI/admin/tes_kenaikan_add_screen.dart';

// FUNCTIONAL SCREEN

class pageRouteApp {
  static final pages = [
    GetPage(name: RouteName.splash_screen, page: () => SplashScreen()),
    GetPage(name: RouteName.onBoard_screen, page: () => OnBoardScreen()),
    GetPage(name: RouteName.login_screen, page: () => LoginScreen()),
    GetPage(name: RouteName.main_user_screen, page: () => MainUserScreen()),

    GetPage(
        name: RouteName.ubah_password_screen, page: () => UbahPasswordScreen()),

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

    // Transaksi Spp
    GetPage(name: RouteName.trans_spp_screen, page: () => TransSppScreen()),

    // Siswa Transaksi Spp
    GetPage(
        name: RouteName.siswa_trans_spp_screen,
        page: () => TransSppSiswaScreen()),

    GetPage(
        name: RouteName.trans_spp_add_screen, page: () => TransSppAddScreen()),

    // Absen
    GetPage(name: RouteName.absen_screen, page: () => AbsenScreen()),
    GetPage(name: RouteName.absen_add_screen, page: () => AbsenAddScreen()),

    // Siswa Absen
    GetPage(name: RouteName.siswa_absen_screen, page: () => SiswaAbsenScreen()),

    // TES KENAIKAN
    GetPage(
        name: RouteName.tes_kenaikan_screen, page: () => TesKenaikanScreen()),
    GetPage(
        name: RouteName.tes_kenaikan_add_screen,
        page: () => TesKenaikanAddScreen()),

    // SISWA TES KENAIKAN
    GetPage(
        name: RouteName.siswa_tes_kenaikan_screen,
        page: () => TesKenaikanDetailSiswaScreen()),

    // LAPORAN
    GetPage(name: RouteName.laporan_screen, page: () => LaporanScreen()),
  ];
}
