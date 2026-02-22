import 'dart:convert';

import 'package:get/get.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var surah = <Surah>[].obs;

  Future getSurah() async { //get all surah
    String url ='https://raw.githubusercontent.com/penggguna/QuranJSON/master/quran.json';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      surah.value = data.map((e) => Surah.fromJson(e)).toList();
      return surah;
    } else { //jika error kosongkan nilai models
      surah.value = [];
    }
  }

  @override
  void onInit() {
    getSurah();
    // TODO: implement onInit
    super.onInit();
  }

 
}
