import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapps_getx/app/data/models/Surah.dart';
import 'package:quranapps_getx/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALquran'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.CARI), //ke halaman cari
            icon: Icon(Icons.search),
          ),
        ],
      ),

      body: DefaultTabController(
        //body dibungkus default tab controller agar tab bar berjalan
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Asslamualaikumn",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                shadowColor: const Color.fromARGB(255, 224, 128, 225),
                color: Colors.transparent,
                child: InkWell(
                  //agar container bisa di klik
                  borderRadius: BorderRadius.circular(15),

                  onTap: () {
                    Get.toNamed(
                      Routes.LAST_READ,
                    ); //arahkan ke halaman last read
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Positioned(
                          right: 10,
                          bottom: 5,
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.menu_book_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Terakhir Dibaca",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Al - Fatihah",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Juz 1 | Ayat 9",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          //warna gradient
                          Colors.purple, //warna pertama
                          Colors.pink, //warna kedua
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TabBar(
                //widget tab bar
                dividerColor: Colors.purple,
                unselectedLabelColor: Colors.pink,
                indicatorColor: Colors.purple,
                labelColor: Colors.purple,
                tabs: [
                  //widget Tabbar
                  Tab(text: "Surah"),

                  Tab(text: "Bookmark"),
                ],
              ),
              Expanded(
                //isi tab bar
                child: TabBarView(
                  //tab bar view harus dibugkus dengan expanded agar tab bar view berjalan
                  children: [
                    FutureBuilder(
                      future: controller.getSurah(),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!asyncSnapshot.hasData) {
                          return Text("tidak ada data");
                        }

                        List dataSurah = asyncSnapshot.data;

                        return ListView.builder(
                          itemCount: dataSurah.length,
                          itemBuilder: (context, index) {
                            Surah surah = dataSurah[index];
                            return ListTile(
                              onTap: () =>
                                  Get.toNamed(Routes.DETAIL, arguments: surah),
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text("${surah.name.transliteration.id}"),
                              subtitle: Text(
                                "${surah.numberOfVerses} || ${surah.revelation.id}",
                              ),
                              trailing: Text(
                                "${surah.name.short}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Center(child: Text("BOOkMark")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
