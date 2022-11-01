// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ta locale. All the
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
  String get localeName => 'ta';

  static String m0(value) =>
      "இந்த உள்ளீடு மதிப்பு ${value}க்கு சமமாக இருக்க வேண்டும்.";

  static String m6(length) =>
      "மதிப்பு ${length}க்கு சமமான நீளத்தைக் கொண்டிருக்க வேண்டும்";

  static String m1(max) =>
      "மதிப்பு ${max} ஐ விட குறைவாகவோ அல்லது சமமாகவோ இருக்க வேண்டும்";

  static String m2(maxLength) =>
      "மதிப்பின் நீளம் ${maxLength} ஐ விட குறைவாகவோ அல்லது சமமாகவோ இருக்க வேண்டும்";

  static String m3(min) =>
      "மதிப்பு ${min} ஐ விட அதிகமாகவோ அல்லது சமமாகவோ இருக்க வேண்டும்.";

  static String m4(minLength) =>
      "மதிப்பு ${minLength} ஐ விட அதிகமாக அல்லது அதற்கு சமமான நீளத்தைக் கொண்டிருக்க வேண்டும்";

  static String m5(value) =>
      "இந்த உள்ளீடு மதிப்பு ${value}க்கு சமமாக இருக்கக்கூடாது.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
            "இந்த உள்ளீட்டுக்கு சரியான கிரெடிட் கார்டு எண் தேவை."),
        "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
            "இந்த உள்ளீட்டுக்கு சரியான தேதி தேவை."),
        "emailErrorText": MessageLookupByLibrary.simpleMessage(
            "இந்த உள்ளீட்டுக்கு சரியான மின்னஞ்சல் முகவரி தேவை."),
        "equalErrorText": m0,
        "equalLengthErrorText": m6,
        "integerErrorText": MessageLookupByLibrary.simpleMessage(
            "இந்த உள்ளீட்டுக்கு சரியான முழு எண் தேவை."),
        "ipErrorText": MessageLookupByLibrary.simpleMessage(
            "இந்த உள்ளீட்டுக்கு சரியான ஐபி தேவை."),
        "matchErrorText": MessageLookupByLibrary.simpleMessage(
            "மதிப்பு முறையுடன் பொருந்தவில்லை."),
        "maxErrorText": m1,
        "maxLengthErrorText": m2,
        "minErrorText": m3,
        "minLengthErrorText": m4,
        "notEqualErrorText": m5,
        "numericErrorText": MessageLookupByLibrary.simpleMessage(
            "மதிப்பு எண்களாக இருக்க வேண்டும்."),
        "requiredErrorText": MessageLookupByLibrary.simpleMessage(
            "இந்த உள்ளீடு காலியாக இருக்கக்கூடாது."),
        "urlErrorText": MessageLookupByLibrary.simpleMessage(
            "இந்த உள்ளீட்டுக்கு சரியான URL முகவரி தேவை.")
      };
}
