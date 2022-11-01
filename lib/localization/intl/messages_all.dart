// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:implementation_imports, file_names, unnecessary_new
// ignore_for_file:unnecessary_brace_in_string_interps, directives_ordering
// ignore_for_file:argument_type_not_assignable, invalid_assignment
// ignore_for_file:prefer_single_quotes, prefer_generic_function_type_aliases
// ignore_for_file:comment_references

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_ar.dart' as messages_ar;
import 'messages_bn.dart' as messages_bn;
import 'messages_bs.dart' as messages_bs;
import 'messages_ca.dart' as messages_ca;
import 'messages_cs.dart' as messages_cs;
import 'messages_de.dart' as messages_de;
import 'messages_en.dart' as messages_en;
import 'messages_es.dart' as messages_es;
import 'messages_et.dart' as messages_et;
import 'messages_fa.dart' as messages_fa;
import 'messages_fr.dart' as messages_fr;
import 'messages_hr.dart' as messages_hr;
import 'messages_hu.dart' as messages_hu;
import 'messages_id.dart' as messages_id;
import 'messages_it.dart' as messages_it;
import 'messages_ja.dart' as messages_ja;
import 'messages_ko.dart' as messages_ko;
import 'messages_lo.dart' as messages_lo;
import 'messages_messages.dart' as messages_messages;
import 'messages_ms.dart' as messages_ms;
import 'messages_nl.dart' as messages_nl;
import 'messages_pl.dart' as messages_pl;
import 'messages_pt.dart' as messages_pt;
import 'messages_ro.dart' as messages_ro;
import 'messages_ru.dart' as messages_ru;
import 'messages_sk.dart' as messages_sk;
import 'messages_sl.dart' as messages_sl;
import 'messages_sw.dart' as messages_sw;
import 'messages_ta.dart' as messages_ta;
import 'messages_th.dart' as messages_th;
import 'messages_tr.dart' as messages_tr;
import 'messages_uk.dart' as messages_uk;
import 'messages_zh_Hans.dart' as messages_zh_hans;
import 'messages_zh_Hant.dart' as messages_zh_hant;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'ar': () => new Future.value(null),
  'bn': () => new Future.value(null),
  'bs': () => new Future.value(null),
  'ca': () => new Future.value(null),
  'cs': () => new Future.value(null),
  'de': () => new Future.value(null),
  'en': () => new Future.value(null),
  'es': () => new Future.value(null),
  'et': () => new Future.value(null),
  'fa': () => new Future.value(null),
  'fr': () => new Future.value(null),
  'hr': () => new Future.value(null),
  'hu': () => new Future.value(null),
  'id': () => new Future.value(null),
  'it': () => new Future.value(null),
  'ja': () => new Future.value(null),
  'ko': () => new Future.value(null),
  'lo': () => new Future.value(null),
  'messages': () => new Future.value(null),
  'ms': () => new Future.value(null),
  'nl': () => new Future.value(null),
  'pl': () => new Future.value(null),
  'pt': () => new Future.value(null),
  'ro': () => new Future.value(null),
  'ru': () => new Future.value(null),
  'sk': () => new Future.value(null),
  'sl': () => new Future.value(null),
  'sw': () => new Future.value(null),
  'ta': () => new Future.value(null),
  'th': () => new Future.value(null),
  'tr': () => new Future.value(null),
  'uk': () => new Future.value(null),
  'zh_Hans': () => new Future.value(null),
  'zh_Hant': () => new Future.value(null),
};

MessageLookupByLibrary? _findExact(String localeName) {
  switch (localeName) {
    case 'ar':
      return messages_ar.messages;
    case 'bn':
      return messages_bn.messages;
    case 'bs':
      return messages_bs.messages;
    case 'ca':
      return messages_ca.messages;
    case 'cs':
      return messages_cs.messages;
    case 'de':
      return messages_de.messages;
    case 'en':
      return messages_en.messages;
    case 'es':
      return messages_es.messages;
    case 'et':
      return messages_et.messages;
    case 'fa':
      return messages_fa.messages;
    case 'fr':
      return messages_fr.messages;
    case 'hr':
      return messages_hr.messages;
    case 'hu':
      return messages_hu.messages;
    case 'id':
      return messages_id.messages;
    case 'it':
      return messages_it.messages;
    case 'ja':
      return messages_ja.messages;
    case 'ko':
      return messages_ko.messages;
    case 'lo':
      return messages_lo.messages;
    case 'messages':
      return messages_messages.messages;
    case 'ms':
      return messages_ms.messages;
    case 'nl':
      return messages_nl.messages;
    case 'pl':
      return messages_pl.messages;
    case 'pt':
      return messages_pt.messages;
    case 'ro':
      return messages_ro.messages;
    case 'ru':
      return messages_ru.messages;
    case 'sk':
      return messages_sk.messages;
    case 'sl':
      return messages_sl.messages;
    case 'sw':
      return messages_sw.messages;
    case 'ta':
      return messages_ta.messages;
    case 'th':
      return messages_th.messages;
    case 'tr':
      return messages_tr.messages;
    case 'uk':
      return messages_uk.messages;
    case 'zh_Hans':
      return messages_zh_hans.messages;
    case 'zh_Hant':
      return messages_zh_hant.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName, (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? new Future.value(false) : lib());
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(String locale) {
  var actualLocale =
      Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
