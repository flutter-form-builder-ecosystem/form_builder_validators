// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sl locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sl';

  static String m0(value) => "Vrednost mora biti enaka ${value}.";

  static String m8(length) => "Besedilo mora biti dolgo ${length} znakov.";

  static String m1(max) => "Vrednost ne sme presegati ${max}.";

  static String m2(maxLength) =>
      "Besedilo mora biti krajše ali enako ${maxLength} znakov.";

  static String m3(maxWordsCount) =>
      "Vrednost mora imeti besede manj kot ali enake ${maxWordsCount}";

  static String m4(min) => "Vrednost mora biti večja ali enaka ${min}.";

  static String m5(minLength) =>
      "Besedilo mora biti daljše ali enako ${minLength} znakov.";

  static String m6(minWordsCount) =>
      "Vrednost mora imeti besede, ki so večje ali enake ${minWordsCount}";

  static String m7(value) => "Vrednost ne sme biti enaka ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Vnesite veljavno številko kreditne kartice."),
        "dateStringErrorText":
            MessageLookupByLibrary.simpleMessage("Vnesite veljaven datum."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Vnesite veljaven e-mail naslov."),
        "equalErrorText": m0,
        "equalLengthErrorText": m8,
        "integerErrorText":
            MessageLookupByLibrary.simpleMessage("Vnesite celo število."),
        "ipErrorText":
            MessageLookupByLibrary.simpleMessage("Vnesite veljaven IP naslov."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Vrednost ne ustreza predpisanemu vzorcu."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "maxWordsCountErrorText": m3,
        "minErrorText": m4,
        "minLengthErrorText": m5,
        "minWordsCountErrorText": m6,
        "notEqualErrorText": m7,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Vrednost polja mora biti numerična."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("Polje ne sme biti prazno."),
        "urlErrorText":
            MessageLookupByLibrary.simpleMessage("Vnesite veljaven URL naslov.")
      };
}
