import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';
import 'package:quranapps_getx/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: FutureBuilder(
        future: controller.getSurah(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!asyncSnapshot.hasData) {
            return Text("tidak ada data");
          }

          List dataSurah = asyncSnapshot.data;

          return ListView.builder(
            itemCount: dataSurah.length,
            itemBuilder: (context, index) {
              Surah surah = dataSurah[index];
              return ListTile(
                onTap: () => Get.toNamed(Routes.DETAIL, arguments: surah), //pindah + lempar data
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Text("${surah.name}"),
                subtitle: Text("${surah.numberOfAyah} | ${surah.type}"),
                trailing: Text(
                  "${surah.nameTranslations.ar}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
