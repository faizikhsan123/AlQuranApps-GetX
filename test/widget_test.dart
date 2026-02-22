import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quranapps_getx/app/data/models/Surah.dart';
import 'package:quranapps_getx/app/data/models/DetailSurah.dart';

Future<void> main() async {
  await getSurah();
}

Future<void> getSurah() async {

  // URL semua surah
  String url =
      "https://raw.githubusercontent.com/penggguna/QuranJSON/master/quran.json";

  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);

    // mapping ke model
    List<Surah> surah =
        data.map((e) => Surah.fromJson(e)).toList();

    print("Total Surah: ${surah.length}");
    print("Surah pertama: ${surah[0].name}");

    // ambil nomor surah pertama
    var nomor = surah[0].numberOfSurah;

    // URL detail
    String url2 = "https://raw.githubusercontent.com/penggguna/QuranJSON/master/surah/$nomor.json";

    var response2 = await http.get(Uri.parse(url2));

    // karena url detail ini berbrntuk objeck / mapping jadi tidak perlu di decode karena json string sama 
    //
    DetailSurah detail = detailSurahFromJson(response2.body);

    print("Total Ayat: ${detail.numberOfAyah}");

  }
}