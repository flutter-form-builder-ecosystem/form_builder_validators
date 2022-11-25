// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ms locale. All the
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
  String get localeName => 'ms';

  static String m0(value) => "Nilai Ruangan ini wajib sama dengan ${value}.";

  static String m8(length) =>
      "Nilai mesti mempunyai panjang yang sama dengan ${length}";

  static String m1(max) =>
      "Nilai wajib kurang daripada atau sama dengan ${max}";

  static String m2(maxLength) =>
      "Nilai mesti mempunyai panjang kurang daripada atau sama dengan ${maxLength}";

  static String m3(maxWordsCount) =>
      "Nilai mesti mempunyai kata -kata yang kurang daripada atau sama dengan ${maxWordsCount}";

  static String m4(min) =>
      "Nilai wajib lebih besar daripada atau sama dengan ${min}.";

  static String m5(minLength) =>
      "Nilai mesti mempunyai panjang lebih besar daripada atau sama dengan ${minLength}";

  static String m6(minWordsCount) =>
      "Nilai mesti mempunyai kata -kata yang lebih besar daripada atau sama dengan ${minWordsCount}";

  static String m7(value) =>
      "Nilai ruangan ini wajib tidak sama dengan ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "Ruangan ini memerlukan nombor kad kredit yang sah."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "Ruangan ini memerlukan rentetan tarikh yang sah."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "Ruang ini memerlukan alamat e-mel yang sah."),
        "equalErrorText": m0,
        "equalLengthErrorText": m8,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "Ruang ini memerlukan integer yang sah."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "Ruangan ini memerlukan IP yang sah."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "Nilai tidak sepadan dengan corak."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "maxWordsCountErrorText": m3,
        "minErrorText": m4,
        "minLengthErrorText": m5,
        "minWordsCountErrorText": m6,
        "notEqualErrorText": m7,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "Nilai wajib dalam bentuk angka."),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("Ruang ini wajib diisi."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "Ruangan ini memerlukan alamat URL yang sah.")
      };
}
