import 'dart:convert';

import 'package:bipres/api/api.dart';
import 'package:bipres/controller/tempat_latihan_controller.dart';
import 'package:bipres/controller/tingkatan_controller.dart';
import 'package:bipres/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

final controller = Get.put(TingkatanController());

class TingkatanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Tingkatan = controller.tingkatan;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff009c3d),
          title: Row(
            children: [
              Icon(Icons.group),
              SizedBox(width: 10),
              Text(
                'Daftar Tingkatan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: controller.getTingkatan,
          child: controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: controller.tingkatan.length,
                    itemBuilder: (context, index) {
                      final data = controller.tingkatan[index];

                      // Render data items
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.school,
                                      size: 40,
                                    ), // Image.asset("assets/images/logo.png"),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data.sabuk,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 2,
                            color: Color(0xfff009c3d),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
