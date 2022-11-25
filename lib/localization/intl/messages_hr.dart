// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hr locale. All the
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
  String get localeName => 'hr';

  static String m0(value) => "Vrijednost mora biti jednaka ${value}.";

  static String m8(length) => "Vrijednost mora biti duga ${length} znakova.";

  static String m1(max) => "Vrijednost mora biti manja ili jednaka ${max}";

  static String m2(maxLength) =>
      "Vrijednost mora biti kraća ili jednaka ${maxLength} znakova.";

  static String m3(maxWordsCount) =>
      "Vrijednost mora imati riječi manje od ili jednake ${maxWordsCount}";

  static String m4(min) => "Vrijednost mora biti veća ili jednaka ${min}.";

  static String m5(minLength) =>
      "Vrijednost mora biti duža ili jednaka ${minLength} znakova.";

  static String m6(minWordsCount) =>
      "Vrijednost mora imati broj riječi veći ili jednak ${minWordsCount}";

  static String m7(value) => "Vrijednost ne smije biti jednaka ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Unesite validan broj kreditne kartice."),
        "dateStringErrorText":
            MessageLookupByLibrary.simpleMessage("Unesite validan datum."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Unesite validnu e-mail adresu."),
        "equalErrorText": m0,
        "equalLengthErrorText": m8,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Vrijednost mora biti cijeli broj."),
        "ipErrorText":
            MessageLookupByLibrary.simpleMessage("Unesite validnu IP adresu."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Vrijednost ne odgovara uzorku."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "maxWordsCountErrorText": m3,
        "minErrorText": m4,
        "minLengthErrorText": m5,
        "minWordsCountErrorText": m6,
        "notEqualErrorText": m7,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Vrijednost mora biti brojčana."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "Ovo polje ne smije biti prazno."),
        "urlErrorText":
            MessageLookupByLibrary.simpleMessage("Unesite validnu URL adresu.")
      };
}
