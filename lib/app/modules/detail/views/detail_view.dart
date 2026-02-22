import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps_getx/app/data/models/DetailSurah.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  Surah dataParam = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${dataParam.name}"), centerTitle: true),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "${dataParam.name.toUpperCase()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "( ${dataParam.nameTranslations.id.toUpperCase()} )",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${dataParam.numberOfAyah} Ayat || ${dataParam.type}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: controller.DetailSurah(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!asyncSnapshot.hasData) {
                  return Text("tidak ada data");
                }

                DetailSurah detail = asyncSnapshot.data; //ambil data dari future builder

                return ListView.builder(
                  itemCount: detail.verses.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                /// HEADER (Nomor + Tombol)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      child: Text("${index + 1}"),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.book),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            
                                            
                                          },
                                          icon: Icon(Icons.play_arrow),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),

                                /// TEKS ARAB (AMAN & CANTIK)
                                Text(
                                  detail.verses[index].text,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: 24,
                                    height: 2, // jarak antar baris biar lega
                                  ),
                                ),

                                SizedBox(height: 20),

                                /// TERJEMAHAN
                                Text(
                                  detail.verses[index].translationId,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 40),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
