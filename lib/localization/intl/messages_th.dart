// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a th locale. All the
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
  String get localeName => 'th';

  static String m0(value) => "ข้อมูลนี้ต้องเท่ากับ ${value} เท่านั้น";

  static String m6(length) => "ความยาวตัวอักษาต้องมีจำนวนเท่ากับ ${length}";

  static String m1(max) => "ข้อมูลนี้ต้องมีค่าน้อยกว่าหรือเท่ากับ ${max}";

  static String m2(maxLength) =>
      "ความยาวตัวอักษาต้องมีจำนวนน้อยกว่าหรือเท่ากับ ${maxLength}";

  static String m3(min) => "ข้อมูลนี้ต้องมีค่ามากกว่าหรือเท่ากับ ${min}";

  static String m4(minLength) =>
      "ความยาวตัวอักษาต้องมีจำนวนมากกว่าหรือเท่ากับ ${minLength}";

  static String m5(value) => "ข้อมูลนี้ต้องไม่เท่ากับ ${value}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "ข้อมูลนี้ต้องเป็นเลขบัตรเครดิตเท่านั้น"),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "ข้อมูลนี้ต้องเป็นวันที่เท่านั้น"),
        "emailErrorText":
            MessageLookupByLibrary.simpleMessage("กรุณาระบุ email ของคุณ"),
        "equalErrorText": m0,
        "equalLengthErrorText": m6,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "ข้อมูลนี้ต้องเป็นตัวเลขเท่านั้น"),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "ข้อมูลนี้ต้องเป็น IP เท่านั้น"),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "ข้อมูลนี้ไม่ตรงกับรูปแบบที่ระบุไว้"),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "ข้อมูลนี้ต้องเป็นตัวเลขเท่านั้น"),
        "requiredErrorText":
            MessageLookupByLibrary.simpleMessage("กรุณาระบุข้อมูล"),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "ข้อมูลนี้ต้องเป็น URL address เท่านั้น")
      };
}
