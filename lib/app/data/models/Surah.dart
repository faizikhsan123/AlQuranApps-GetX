// To parse this JSON data, do
//
//     final surah = surahFromJson(jsonString);

import 'dart:convert';

Surah surahFromJson(String str) => Surah.fromJson(json.decode(str));

String surahToJson(Surah data) => json.encode(data.toJson());

class Surah {
    String name;
    NameTranslations nameTranslations;
    int numberOfAyah;
    int numberOfSurah;
    String place;
    String recitation;
    String type;

    Surah({
        required this.name,
        required this.nameTranslations,
        required this.numberOfAyah,
        required this.numberOfSurah,
        required this.place,
        required this.recitation,
        required this.type,
    });

    factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        name: json["name"],
        nameTranslations: NameTranslations.fromJson(json["name_translations"]),
        numberOfAyah: json["number_of_ayah"],
        numberOfSurah: json["number_of_surah"],
        place: json["place"],
        recitation: json["recitation"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "name_translations": nameTranslations.toJson(),
        "number_of_ayah": numberOfAyah,
        "number_of_surah": numberOfSurah,
        "place": place,
        "recitation": recitation,
        "type": type,
    };
}

class NameTranslations {
    String ar;
    String en;
    String id;

    NameTranslations({
        required this.ar,
        required this.en,
        required this.id,
    });

    factory NameTranslations.fromJson(Map<String, dynamic> json) => NameTranslations(
        ar: json["ar"],
        en: json["en"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "ar": ar,
        "en": en,
        "id": id,
    };
}
