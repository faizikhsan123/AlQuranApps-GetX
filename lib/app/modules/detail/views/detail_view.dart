import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {


  Surah dataParam = Get.arguments;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailView'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.DetailSurah(),
        builder: (context, asyncSnapshot) {

          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Text("data");

          // List data = asyncSnapshot.data;
          // return ListView.builder(
          //   itemCount: data.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       leading: CircleAvatar(child: Text("${index + 1}")),
          //       title: Text("data"),
          //     );
          // },);
        }
      ),
    );
  }
}
