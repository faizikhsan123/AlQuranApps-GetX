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

                final detail = asyncSnapshot.data!; //detail surah

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
                                    GetBuilder<DetailController>(
                                      builder: (controller) {
                                        final isThisPlaying =
                                            controller.playingIndex == index;
                                        final isPlaying =
                                            controller.player.playing;

                                        return Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.book),
                                              onPressed: () {},
                                            ),

                                            /// kalau ayat ini sedang diputar
                                            if (isThisPlaying && isPlaying)
                                              IconButton(
                                                icon: Icon(Icons.pause),
                                                onPressed: () {
                                                  controller.pauseAudio();
                                                },
                                              )
                                            else
                                              IconButton(
                                                icon: Icon(Icons.play_arrow),
                                                onPressed: () {
                                                  controller.playAudio(
                                                    detail
                                                        .verses[index]
                                                        .audio
                                                        .primary,
                                                    index,
                                                  );
                                                },
                                              ),

                                            /// tombol stop hanya muncul kalau ayat ini aktif
                                            if (isThisPlaying)
                                              IconButton(
                                                icon: Icon(Icons.stop),
                                                onPressed: () {
                                                  controller.stopAudio();
                                                },
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),

                                /// TEKS ARAB (AMAN & CANTIK)
                                Text(
                                  "${detail.verses[index].text.arab}",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    fontSize: 24,
                                    height: 2, // jarak antar baris biar lega
                                  ),
                                ),

                                /// TEKS ARAB (AMAN & CANTIK)
                                Text(
                                  "${detail.verses[index].text.transliteration.en}",
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
