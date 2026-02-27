import 'package:get/get.dart';

import '../modules/cari/bindings/cari_binding.dart';
import '../modules/cari/views/cari_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/detail_juz/bindings/detail_juz_binding.dart';
import '../modules/detail_juz/views/detail_juz_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro_view.dart';
import '../modules/last_read/bindings/last_read_binding.dart';
import '../modules/last_read/views/last_read_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.CARI,
      page: () =>  CariView(),
      binding: CariBinding(),
    ),
    GetPage(
      name: _Paths.LAST_READ,
      page: () =>  LastReadView(),
      binding: LastReadBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_JUZ,
      page: () =>  DetailJuzView(),
      binding: DetailJuzBinding(),
    ),
  ];
}
