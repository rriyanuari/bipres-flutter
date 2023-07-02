import 'dart:developer';

import 'package:bipres/UI/auth/ubah_password_screen.dart';
import 'package:bipres/controller/auth_controller.dart';
import 'package:bipres/controller/pref_controller.dart';
import 'package:bipres/controller/profile_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:bipres/shared/loadingWidget.dart';
import 'package:bipres/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  PrefController prefController = Get.put(PrefController());

  signOut() async {
    authController.logout(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profiles = profileController.Profile;
    final prefs = prefController.myDataPref;

    inspect(prefs);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => profileController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 80.0, left: 30.0, right: 30, bottom: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/defaultProfiPic.png'))),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "${profiles[0].namaLengkap}",
                              style: h1.copyWith(
                                  color: secondarySoftColor, fontWeight: bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            (prefs['role'] == 'admin')
                                ? Text(
                                    "---   ${prefs['role']}   ---",
                                    style: h3.copyWith(
                                      color: whiteColor,
                                      fontWeight: regular,
                                    ),
                                  )
                                : Text(
                                    "---   ${profiles[0].role}   ---",
                                    style: h3.copyWith(
                                      color: whiteColor,
                                      fontWeight: regular,
                                    ),
                                  ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Jenis Kelamin',
                                    style: h4.copyWith(
                                        color: whiteColor, fontWeight: regular),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    ':   ${profiles[0].jenisKelamin}',
                                    style: h4.copyWith(
                                        color: whiteColor, fontWeight: regular),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Tanggal Lahir',
                                    style: h4.copyWith(
                                        color: whiteColor, fontWeight: regular),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    ':   ${profiles[0].tanggalLahir}',
                                    style: h4.copyWith(
                                        color: whiteColor, fontWeight: regular),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Tempat Latihan',
                                    style: h4.copyWith(
                                        color: whiteColor, fontWeight: regular),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    ':   ${profiles[0].tempatLatihan}',
                                    style: h4.copyWith(
                                        color: whiteColor, fontWeight: regular),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            (profiles[0].sabuk != null)
                                ? Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Sabuk',
                                          style: h4.copyWith(
                                              color: whiteColor,
                                              fontWeight: regular),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          ':   ${profiles[0].sabuk}',
                                          style: h4.copyWith(
                                              color: whiteColor,
                                              fontWeight: regular),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Tahun Pengesahan',
                                          style: h4.copyWith(
                                              color: whiteColor,
                                              fontWeight: regular),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          ':   ${profiles[0].tahunPengesahan}',
                                          style: h4.copyWith(
                                              color: whiteColor,
                                              fontWeight: regular),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Username',
                                    style: h4.copyWith(
                                        color: whiteColor, fontWeight: regular),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    ':   ${prefs['username']}',
                                    style: h4.copyWith(
                                        color: whiteColor, fontWeight: regular),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minWidth: 400.0,
                              height: 50.0,
                              color: whiteColor,
                              child: Text(
                                "UBAH PASSWORD",
                                style: h4.copyWith(
                                    fontWeight: bold, color: primaryColor),
                              ),
                              onPressed: () {
                                Get.toNamed(RouteName.ubah_password_screen);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minWidth: 400.0,
                              height: 50.0,
                              color: secondarySoftColor,
                              child: Text(
                                "KELUAR",
                                style: h4.copyWith(
                                    fontWeight: bold, color: primaryColor),
                              ),
                              onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title:
                                        const Text('Apakah anda ingin keluar?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          signOut();
                                        },
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                loadingWidget(context, authController.isLoading.value)
              ],
            )),
    );
  }
}
