// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a cs locale. All the
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
  String get localeName => 'cs';

  static String m0(value) => "Hodnota se musí rovnat ${value}.";

  static String m6(length) => "Hodnota musí mít délku rovnu ${length}";

  static String m1(max) => "Hodnota musí být menší než nebo rovna ${max}.";

  static String m2(maxLength) =>
      "Hodnota musí mít délku menší než nebo rovnu ${maxLength}.";

  static String m3(min) => "Hodnota musí být větší než nebo rovna ${min}.";

  static String m4(minLength) =>
      "Hodnota musí mít délku větší než nebo rovnu ${minLength}";

  static String m5(value) => "Hodnota se nesmí rovnat ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Pole vyžaduje platné číslo kreditní karty."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Pole vyžaduje platný zápis data."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Pole vyžaduje platnou e-mailovou adresu."),
        "equalErrorText": m0,
        "equalLengthErrorText": m6,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Hodnota musí být celé číslo."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Pole vyžaduje platnou IP adresu."),
        "matchErrorText":
            MessageLookupByLibrary.simpleMessage("Hodnota neodpovídá vzoru."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText":
            MessageLookupByLibrary.simpleMessage("Hodnota musí být číslo."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("Pole nemůže být prázdné."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Pole vyžaduje platnou adresu URL.")
      };
}
