import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps_getx/app/data/models/DetailSurah.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    Surah dataParameter = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Detail Surah "), centerTitle: true),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "${dataParameter.name.transliteration.id}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "(${dataParameter.name.translation.id})",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${dataParameter.numberOfVerses} Ayat || ${dataParameter.revelation.id}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<DetailSurah?>(
              future: controller.getDetailSurah(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!asyncSnapshot.hasData) {
                  return Center(child: Text("Data Tidak Ditemukan"));
                }

                final detail = asyncSnapshot.data!; 

               

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
                                            //jalnakan audio dan kirim parameter
                                            controller.playAudio("${detail.verses[index].audio.primary}");
                                          },
                                          icon: Icon(Icons.play_arrow),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),

                                
                                Text(
                                  "${detail.verses[index].text.arab}",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: 24,
                                    height: 2, 
                                  ),
                                ),
                                
                                Text(
                                  "${detail.verses[index].text.transliteration.en}",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: 24,
                                    height: 2, 
                                  ),
                                ),

                                SizedBox(height: 20),

                                
                                Text(
                                  "${detail.verses[index].translation.id}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
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
