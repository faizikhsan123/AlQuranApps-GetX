import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:quranapps_getx/app/data/models/DetailSurah.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';

class DetailController extends GetxController {
  Surah idParam = Get.arguments;

  final AudioPlayer player = AudioPlayer();

  DetailSurah? detail;
  int? playingIndex; // ayat mana yang sedang diputar

  Future<DetailSurah?> getDetailSurah() async {
    String url =
        'https://quran-api-id.vercel.app/surah/${idParam.number}';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final detailsurah = data["data"];

      detail = DetailSurah.fromJson(detailsurah);
      update();
      return detail;
    }

    return null;
  }

  Future playAudio(String url, int index) async {
    try {
      if (playingIndex != index) {
        await player.setUrl(url);
        playingIndex = index;
      }

      await player.play();
      update();
    } catch (e) {
      Get.defaultDialog(title: 'Error', middleText: '$e');
    }
  }

  Future pauseAudio() async {
    await player.pause();
    update();
  }

  Future stopAudio() async {
    await player.stop();
    playingIndex = null;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    /// 🔥 LISTENER REALTIME
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playingIndex = null;
      }
      update();
    });
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}