import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_juz_controller.dart';
import '../../../data/models/Juz.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  @override
  Widget build(BuildContext context) {
    final int nomorJuz = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Juz $nomorJuz"),
        centerTitle: true,
      ),
      body: FutureBuilder<Juz?>(
        future: controller.getJuz(nomorJuz),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!asyncSnapshot.hasData) {
            return Center(child: Text("Data Tidak Ditemukan"));
          }

          final juz = asyncSnapshot.data!;

          return ListView(
            children: [
              // ── INFO JUZ ──────────────────────────────────────
              Card(
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(juz.juzStartInfo ?? "",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(juz.juzEndInfo ?? "",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("Total Ayat : ${juz.totalVerses}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),

              // ── LIST AYAT ─────────────────────────────────────
              ListView.builder(
                itemCount: juz.verses.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final verse = juz.verses[index];
                  final isFirstAyahOfSurah = verse.number.inSurah == 1;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // ── HEADER SURAH (muncul kalau ayat ke-1 surah baru) ──
                      if (isFirstAyahOfSurah)
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Nomor surah dalam lingkaran
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white24,
                                child: Text(
                                  "${verse.number.inQuran - verse.number.inSurah + 1}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Nama surah (dari meta/data jika tersedia,
                              // fallback pakai nomor ayat di Quran)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Surah Baru",          // ← ganti dengan nama surah jika model menyimpannya
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "Ayat ke-${verse.number.inQuran} Al-Qur'an",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      // ── CARD AYAT ──────────────────────────────
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Header baris: nomor + tombol audio
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    child: Text("${verse.number.inSurah}"),
                                  ),
                                  GetBuilder<DetailJuzController>(
                                    builder: (ctrl) {
                                      final isThisPlaying =
                                          ctrl.playingIndex == index;
                                      final isPlaying = ctrl.player.playing;

                                      return Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.book),
                                            onPressed: () {},
                                          ),
                                          if (isThisPlaying && isPlaying)
                                            IconButton(
                                              icon: Icon(Icons.pause),
                                              onPressed: ctrl.pauseAudio,
                                            )
                                          else
                                            IconButton(
                                              icon: Icon(Icons.play_arrow),
                                              onPressed: () => ctrl.playAudio(
                                                verse.audio.primary,
                                                index,
                                              ),
                                            ),
                                          if (isThisPlaying)
                                            IconButton(
                                              icon: Icon(Icons.stop),
                                              onPressed: ctrl.stopAudio,
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(height: 16),

                              // Teks Arab
                              Text(
                                verse.text.arab,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 24, height: 2),
                              ),

                              SizedBox(height: 8),

                              // Transliterasi
                              Text(
                                verse.text.transliteration.en,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[600],
                                ),
                              ),

                              SizedBox(height: 12),

                              // Terjemahan
                              Text(
                                verse.translation.id,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 4),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}