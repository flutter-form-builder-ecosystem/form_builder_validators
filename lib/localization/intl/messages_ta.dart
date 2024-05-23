import 'messages.dart';

/// The translations for Tamil (`ta`).
class FormBuilderLocalizationsImplTa extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplTa([String locale = 'ta']) : super(locale);

  @override
  String get creditCardErrorText =>
      'இந்த உள்ளீட்டுக்கு சரியான கிரெடிட் கார்டு எண் தேவை.';

  @override
  String get dateStringErrorText => 'இந்த உள்ளீட்டுக்கு சரியான தேதி தேவை.';

  @override
  String get emailErrorText =>
      'இந்த உள்ளீட்டுக்கு சரியான மின்னஞ்சல் முகவரி தேவை.';

  @override
  String equalErrorText(Object value) {
    return 'இந்த உள்ளீடு மதிப்பு $valueக்கு சமமாக இருக்க வேண்டும்.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'மதிப்பு $lengthக்கு சமமான நீளத்தைக் கொண்டிருக்க வேண்டும்';
  }

  @override
  String get integerErrorText => 'இந்த உள்ளீட்டுக்கு சரியான முழு எண் தேவை.';

  @override
  String get ipErrorText => 'இந்த உள்ளீட்டுக்கு சரியான ஐபி தேவை.';

  @override
  String get matchErrorText => 'மதிப்பு முறையுடன் பொருந்தவில்லை.';

  @override
  String maxErrorText(Object max) {
    return 'மதிப்பு $max ஐ விட குறைவாகவோ அல்லது சமமாகவோ இருக்க வேண்டும்';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'மதிப்பின் நீளம் $maxLength ஐ விட குறைவாகவோ அல்லது சமமாகவோ இருக்க வேண்டும்';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'மதிப்பை விட குறைவாகவோ அல்லது சமமாகவோ மதிப்பிடப்பட வேண்டும் $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'மதிப்பு $min ஐ விட அதிகமாகவோ அல்லது சமமாகவோ இருக்க வேண்டும்.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'மதிப்பு $minLength ஐ விட அதிகமாக அல்லது அதற்கு சமமான நீளத்தைக் கொண்டிருக்க வேண்டும்';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'மதிப்பை விட அதிகமாகவோ அல்லது சமமாகவோ மதிப்பிடப்பட வேண்டும் $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'இந்த உள்ளீடு மதிப்பு $valueக்கு சமமாக இருக்கக்கூடாது.';
  }

  @override
  String get numericErrorText => 'மதிப்பு எண்களாக இருக்க வேண்டும்.';

  @override
  String get requiredErrorText => 'இந்த உள்ளீடு காலியாக இருக்கக்கூடாது.';

  @override
  String get urlErrorText => 'இந்த உள்ளீட்டுக்கு சரியான URL முகவரி தேவை.';
}
