import 'dart:convert';

import 'package:get/get.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var surah = <Surah>[].obs;

  Future getSurah() async {
    //get all surah
    String url = 'https://quran-api-id.vercel.app/surah';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      

      //{code: 200, status: OK., message: Success fetching all surah., data: [{number: 1, sequence: 5, numberOfVerses: 7, name: {short: الفاتحة, long: سُورَةُ ٱلْفَاتِحَةِ, transliteration: {en: Al-Faatiha, id: Al-Fatihah}, translation: {en: The Opening, id: Pembukaan}}, revelation: {arab: مكة, en: Meccan, id: Makkiyyah}, tafsir: {id: Surat Al Faatihah (Pembukaan) yang diturunkan di Mekah dan terdiri dari 7 ayat adalah surat yang pertama-tama diturunkan dengan lengkap  diantara surat-surat yang ada dalam Al Quran dan termasuk golongan surat Makkiyyah. Surat ini disebut Al Faatihah (Pembukaan), karena dengan surat inilah dibuka dan dimulainya Al Quran. Dinamakan Ummul Quran (induk Al Quran) atau Ummul Kitaab (induk Al Kitaab) karena dia merupakan induk dari semua isi Al Quran, dan karena itu diwajibkan membacanya pada tiap-tiap sembahyang. Dinamakan pula As Sab'ul matsaany (tujuh yang berulang-ulang) karena ayatnya tujuh dan dibaca berulang-ulang dalam sholat.}},

      //karena hasilnya seperti itu kita hanya perlu mengambil yg ada didalm bagian datanya saja

      final List dataSUrah = data['data'];
      surah.value = dataSUrah.map((e) => Surah.fromJson(e)).toList();

      return surah;
    } else {
      //jika error kosongkan nilai models
      surah.value = [];
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
