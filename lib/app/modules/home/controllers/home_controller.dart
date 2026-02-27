import 'dart:convert';

import 'package:get/get.dart';
import 'package:quranapps_getx/app/data/models/Juz.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var surah = <Surah>[].obs;
  Juz? jus; //models juz

  Future getSurah() async {
    //get all surah
    String url = 'https://quran-api-id.vercel.app/surah';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List dataSUrah = data['data'];
      surah.value = dataSUrah.map((e) => Surah.fromJson(e)).toList();

      return surah;
    } else {
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
