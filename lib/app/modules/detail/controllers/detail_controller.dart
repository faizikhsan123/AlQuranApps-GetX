import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quranapps_getx/app/data/models/DetailSurah.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';

DetailSurah? detail; //detail surah typenya models

class DetailController extends GetxController {
  Surah idParam = Get.arguments;

  Future DetailSurah() async {
    String url =
        'https://raw.githubusercontent.com/penggguna/QuranJSON/master/surah/${idParam.numberOfSurah}.json';
    var response = await http.get(Uri.parse(url));

    //karena inni berbrntuk objeck / mapping jadi tidak perlu di map dan dimasukkan ke list
    detail = detailSurahFromJson(response.body); //detail surah typenya models
    return detail;
  }

 

  @override
  void onInit() {
    DetailSurah();
    // TODO: implement onInit
    super.onInit();
  }
}
