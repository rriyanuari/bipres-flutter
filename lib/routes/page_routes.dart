import 'package:bipres/UI/admin/athletes_screen.dart';
import 'package:bipres/UI/admin/sekolahAdd_screen.dart';
import 'package:bipres/UI/admin/sekolah_screen.dart';
import 'package:bipres/UI/auth/login_screen.dart';
import 'package:bipres/UI/onBoard_screen.dart';
import 'package:bipres/UI/splash_screen.dart';
import 'package:bipres/UI/admin/athletesAdd_screen.dart';
import 'package:bipres/UI/main_user_screen.dart';
import 'package:bipres/routes/route_name.dart';
// import 'package:final_project/UI/login_screen.dart';
// import 'package:final_project/UI/register_screen.dart';

import 'package:get/get.dart';

class pageRouteApp {
  static final pages = [
    GetPage(name: RouteName.splash_screen, page: () => SplashScreen()),
    GetPage(name: RouteName.onBoard_screen, page: () => onBoardScreen()),
    GetPage(name: RouteName.login_screen, page: () => LoginScreen()),
    GetPage(name: RouteName.main_user_screen, page: () => MainUserScreen()),

    // Sekolah
    GetPage(name: RouteName.sekolah_screen, page: () => SekolahScreen()),
    GetPage(name: RouteName.sekolah_add_screen, page: () => sekolahAddScreen()),

    // Athletes
    GetPage(name: RouteName.athletes_screen, page: () => AhtletesScreen()),
    GetPage(
        name: RouteName.athletes_add_screen, page: () => athletesAddScreen()),
  ];
}
