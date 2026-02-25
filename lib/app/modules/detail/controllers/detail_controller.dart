import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quranapps_getx/app/data/models/DetailSurah.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';

DetailSurah? detail; //dia tidak list karena uda object

class DetailController extends GetxController {
  Surah idParam = Get.arguments;

  Future<DetailSurah?> getDetailSurah() async {
    String url =
        'https://quran-api-id.vercel.app/surah/${idParam.number}'; //sesuai id surah

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // 🔥 AMBIL BAGIAN DATA
      final detailsurah = data["data"];

      final detail = DetailSurah.fromJson(detailsurah);

      return detail;
    }

    return null;
  }

  @override
  void onInit() {
    getDetailSurah();

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    getDetailSurah();
    // player.stop();
    // player.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
