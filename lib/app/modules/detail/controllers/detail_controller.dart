import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:quranapps_getx/app/data/models/DetailSurah.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';

DetailSurah? detail;
final player = AudioPlayer(); //inisialize audioplayer

class DetailController extends GetxController {
  Surah idParam = Get.arguments;

  Future<DetailSurah?> getDetailSurah() async {
    String url = 'https://quran-api-id.vercel.app/surah/${idParam.number}';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final detailsurah = data["data"];

      final detail = DetailSurah.fromJson(detailsurah);

      return detail;
    }

    return null;
  }

  Future playAudio(String url) async {
    try {
      await player.setUrl(url);
      await player.play();
    } on PlayerException catch (e) {
      // Playback failed
      Get.defaultDialog(title: 'Error', middleText: '"Error code: ${e.code}"');

      Get.defaultDialog(
        title: 'Error',
        middleText: '"Error message: ${e.message}"',
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: 'Error',
        middleText: '"Connection aborted: ${e.message}"',
      );
    } catch (e) {
      // Fallback for all other errors
      Get.defaultDialog(title: 'Error', middleText: 'An error occured: $e');
    }

    // Listening to errors during playback (e.g. lost network connection)
    player.errorStream.listen((PlayerException e) {
      print('Error code: ${e.code}');
      print('Error message: ${e.message}');
      print('AudioSource index: ${e.index}');
    });
  }

  @override
  void onInit() {
    getDetailSurah();

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    getDetailSurah();
    super.onClose();
  }
}
