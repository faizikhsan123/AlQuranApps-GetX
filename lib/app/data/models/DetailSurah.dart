// To parse this JSON data, do
//
//     final detailSurah = detailSurahFromJson(jsonString);

import 'dart:convert';

DetailSurah detailSurahFromJson(String str) => DetailSurah.fromJson(json.decode(str));

String detailSurahToJson(DetailSurah data) => json.encode(data.toJson());

class DetailSurah {
    String name;
    NameTranslations nameTranslations;
    int numberOfAyah;
    int numberOfSurah;
    String place;
    List<Recitation> recitations;
    String type;
    List<Verse> verses;
    Tafsir tafsir;

    DetailSurah({
        required this.name,
        required this.nameTranslations,
        required this.numberOfAyah,
        required this.numberOfSurah,
        required this.place,
        required this.recitations,
        required this.type,
        required this.verses,
        required this.tafsir,
    });

    factory DetailSurah.fromJson(Map<String, dynamic> json) => DetailSurah(
        name: json["name"],
        nameTranslations: NameTranslations.fromJson(json["name_translations"]),
        numberOfAyah: json["number_of_ayah"],
        numberOfSurah: json["number_of_surah"],
        place: json["place"],
        recitations: List<Recitation>.from(json["recitations"].map((x) => Recitation.fromJson(x))),
        type: json["type"],
        verses: List<Verse>.from(json["verses"].map((x) => Verse.fromJson(x))),
        tafsir: Tafsir.fromJson(json["tafsir"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "name_translations": nameTranslations.toJson(),
        "number_of_ayah": numberOfAyah,
        "number_of_surah": numberOfSurah,
        "place": place,
        "recitations": List<dynamic>.from(recitations.map((x) => x.toJson())),
        "type": type,
        "verses": List<dynamic>.from(verses.map((x) => x.toJson())),
        "tafsir": tafsir.toJson(),
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

class Recitation {
    String name;
    String audioUrl;

    Recitation({
        required this.name,
        required this.audioUrl,
    });

    factory Recitation.fromJson(Map<String, dynamic> json) => Recitation(
        name: json["name"],
        audioUrl: json["audio_url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "audio_url": audioUrl,
    };
}

class Tafsir {
    Id id;

    Tafsir({
        required this.id,
    });

    factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        id: Id.fromJson(json["id"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id.toJson(),
    };
}

class Id {
    Kemenag kemenag;

    Id({
        required this.kemenag,
    });

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        kemenag: Kemenag.fromJson(json["kemenag"]),
    );

    Map<String, dynamic> toJson() => {
        "kemenag": kemenag.toJson(),
    };
}

class Kemenag {
    String name;
    String source;
    Map<String, String> text;

    Kemenag({
        required this.name,
        required this.source,
        required this.text,
    });

    factory Kemenag.fromJson(Map<String, dynamic> json) => Kemenag(
        name: json["name"],
        source: json["source"],
        text: Map.from(json["text"]).map((k, v) => MapEntry<String, String>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "source": source,
        "text": Map.from(text).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}

class Verse {
    int number;
    String text;
    String translationEn;
    String translationId;

    Verse({
        required this.number,
        required this.text,
        required this.translationEn,
        required this.translationId,
    });

    factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        number: json["number"],
        text: json["text"],
        translationEn: json["translation_en"],
        translationId: json["translation_id"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "text": text,
        "translation_en": translationEn,
        "translation_id": translationId,
    };
}
