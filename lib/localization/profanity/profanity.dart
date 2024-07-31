import 'package:intl/intl.dart' as intl;

import 'profanity_ar.dart';
import 'profanity_bg.dart';
import 'profanity_bn.dart';
import 'profanity_bs.dart';
import 'profanity_ca.dart';
import 'profanity_cs.dart';
import 'profanity_da.dart';
import 'profanity_de.dart';
import 'profanity_el.dart';
import 'profanity_en.dart';
import 'profanity_es.dart';
import 'profanity_et.dart';
import 'profanity_fa.dart';
import 'profanity_fi.dart';
import 'profanity_fr.dart';
import 'profanity_he.dart';
import 'profanity_hi.dart';
import 'profanity_hr.dart';
import 'profanity_hu.dart';
import 'profanity_id.dart';
import 'profanity_it.dart';
import 'profanity_ja.dart';
import 'profanity_km.dart';
import 'profanity_ko.dart';
import 'profanity_ku.dart';
import 'profanity_lo.dart';
import 'profanity_mn.dart';
import 'profanity_ms.dart';
import 'profanity_ne.dart';
import 'profanity_nl.dart';
import 'profanity_no.dart';
import 'profanity_pl.dart';
import 'profanity_pt.dart';
import 'profanity_ro.dart';
import 'profanity_ru.dart';
import 'profanity_sk.dart';
import 'profanity_sl.dart';
import 'profanity_sq.dart';
import 'profanity_sv.dart';
import 'profanity_sw.dart';
import 'profanity_ta.dart';
import 'profanity_th.dart';
import 'profanity_tr.dart';
import 'profanity_uk.dart';
import 'profanity_vi.dart';
import 'profanity_zh.dart';
import 'profanity_zh_hant.dart';

/// {@template profanity_template}
/// Base class for all profanity lists.
/// {@endtemplate}
abstract class Profanity {
  /// Creates a new instance of the profanity list.
  Profanity(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  /// The locale name for the profanity list.
  final String localeName;

  /// The list of profanity words.
  List<String> get profanityList;

  /// The list of supported locales.
  static List<Profanity> supportedLocales = <Profanity>[
    ProfanityAr(),
    ProfanityBg(),
    ProfanityBn(),
    ProfanityBs(),
    ProfanityCa(),
    ProfanityCs(),
    ProfanityDa(),
    ProfanityDe(),
    ProfanityEl(),
    ProfanityEn(),
    ProfanityEs(),
    ProfanityEt(),
    ProfanityFa(),
    ProfanityFi(),
    ProfanityFr(),
    ProfanityHe(),
    ProfanityHi(),
    ProfanityHr(),
    ProfanityHu(),
    ProfanityId(),
    ProfanityIt(),
    ProfanityJa(),
    ProfanityKm(),
    ProfanityKo(),
    ProfanityKu(),
    ProfanityLo(),
    ProfanityMn(),
    ProfanityMs(),
    ProfanityNe(),
    ProfanityNl(),
    ProfanityNo(),
    ProfanityPl(),
    ProfanityPt(),
    ProfanityRo(),
    ProfanityRu(),
    ProfanitySk(),
    ProfanitySl(),
    ProfanitySq(),
    ProfanitySv(),
    ProfanitySw(),
    ProfanityTa(),
    ProfanityTh(),
    ProfanityTr(),
    ProfanityUk(),
    ProfanityVi(),
    ProfanityZhHant(),
    ProfanityZh()
  ];

  /// Returns the profanity list for the given locale.
  static Profanity of(String locale) {
    return supportedLocales.firstWhere(
      (Profanity profanity) => profanity.localeName == locale,
      orElse: () => ProfanityEn(),
    );
  }

  /// Returns the profanity list for the given locales.
  static List<Profanity> ofLocales(List<String> locales) {
    return locales.map((String locale) => of(locale)).toList();
  }

  /// Returns the list of profanity words for the given list of profanity.
  static List<String> profanityListOf(List<Profanity> profanity) {
    return profanity
        .map((Profanity profanity) => profanity.profanityList)
        .expand((List<String> list) => list)
        .toList();
  }

  /// Returns the list of profanity words for the given list of locales.
  static List<String> profanityListOfLocales(List<String> locales) {
    return profanityListOf(ofLocales(locales));
  }

  /// Returns the list of profanity words for all supported locales.
  static List<String> profanityListAll() {
    return profanityListOf(supportedLocales);
  }
}
