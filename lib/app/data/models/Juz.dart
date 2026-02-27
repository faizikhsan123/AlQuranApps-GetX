import 'dart:convert';

Juz juzFromJson(String str) => Juz.fromJson(json.decode(str));

String juzToJson(Juz data) => json.encode(data.toJson());

class Juz {
  int juz;
  int juzStartSurahNumber;
  int juzEndSurahNumber;
  String juzStartInfo;
  String juzEndInfo;
  int totalVerses;
  List<JuzVerse> verses;

  Juz({
    required this.juz,
    required this.juzStartSurahNumber,
    required this.juzEndSurahNumber,
    required this.juzStartInfo,
    required this.juzEndInfo,
    required this.totalVerses,
    required this.verses,
  });

  factory Juz.fromJson(Map<String, dynamic> json) => Juz(
        juz: json["juz"] ?? 0,
        juzStartSurahNumber: json["juzStartSurahNumber"] ?? 0,
        juzEndSurahNumber: json["juzEndSurahNumber"] ?? 0,
        juzStartInfo: json["juzStartInfo"] ?? "",
        juzEndInfo: json["juzEndInfo"] ?? "",
        totalVerses: json["totalVerses"] ?? 0,
        verses: json["verses"] == null
            ? []
            : List<JuzVerse>.from(
                json["verses"].map((x) => JuzVerse.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "juzStartSurahNumber": juzStartSurahNumber,
        "juzEndSurahNumber": juzEndSurahNumber,
        "juzStartInfo": juzStartInfo,
        "juzEndInfo": juzEndInfo,
        "totalVerses": totalVerses,
        "verses": List<dynamic>.from(verses.map((x) => x.toJson())),
      };
}

class JuzVerse {
  JuzNumber number;
  JuzMeta meta;
  JuzText text;
  JuzTranslation translation;
  JuzAudio audio;

  JuzVerse({
    required this.number,
    required this.meta,
    required this.text,
    required this.translation,
    required this.audio,
  });

  factory JuzVerse.fromJson(Map<String, dynamic> json) => JuzVerse(
        number: JuzNumber.fromJson(json["number"] ?? {}),
        meta: JuzMeta.fromJson(json["meta"] ?? {}),
        text: JuzText.fromJson(json["text"] ?? {}),
        translation: JuzTranslation.fromJson(json["translation"] ?? {}),
        audio: JuzAudio.fromJson(json["audio"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "number": number.toJson(),
        "meta": meta.toJson(),
        "text": text.toJson(),
        "translation": translation.toJson(),
        "audio": audio.toJson(),
      };
}

class JuzNumber {
  int inQuran;
  int inSurah;

  JuzNumber({
    required this.inQuran,
    required this.inSurah,
  });

  factory JuzNumber.fromJson(Map<String, dynamic> json) => JuzNumber(
        inQuran: json["inQuran"] ?? 0,
        inSurah: json["inSurah"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class JuzMeta {
  int juz;
  int page;
  int manzil;
  int ruku;
  int hizbQuarter;

  JuzMeta({
    required this.juz,
    required this.page,
    required this.manzil,
    required this.ruku,
    required this.hizbQuarter,
  });

  factory JuzMeta.fromJson(Map<String, dynamic> json) => JuzMeta(
        juz: json["juz"] ?? 0,
        page: json["page"] ?? 0,
        manzil: json["manzil"] ?? 0,
        ruku: json["ruku"] ?? 0,
        hizbQuarter: json["hizbQuarter"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
      };
}

/// 🔥 INI YANG PENTING — TIDAK PAKAI NAMA "Text"
class JuzText {
  String arab;
  JuzTransliteration transliteration;

  JuzText({
    required this.arab,
    required this.transliteration,
  });

  factory JuzText.fromJson(Map<String, dynamic> json) => JuzText(
        arab: json["arab"] ?? "",
        transliteration:
            JuzTransliteration.fromJson(json["transliteration"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration.toJson(),
      };
}

class JuzTransliteration {
  String en;

  JuzTransliteration({
    required this.en,
  });

  factory JuzTransliteration.fromJson(Map<String, dynamic> json) =>
      JuzTransliteration(
        en: json["en"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class JuzTranslation {
  String en;
  String id;

  JuzTranslation({
    required this.en,
    required this.id,
  });

  factory JuzTranslation.fromJson(Map<String, dynamic> json) =>
      JuzTranslation(
        en: json["en"] ?? "",
        id: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}

class JuzAudio {
  String primary;
  List<String> secondary;

  JuzAudio({
    required this.primary,
    required this.secondary,
  });

  factory JuzAudio.fromJson(Map<String, dynamic> json) => JuzAudio(
        primary: json["primary"] ?? "",
        secondary: json["secondary"] == null
            ? []
            : List<String>.from(json["secondary"]),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary,
      };
}