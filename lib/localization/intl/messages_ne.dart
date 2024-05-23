import 'messages.dart';

/// The translations for Nepali (`ne`).
class FormBuilderLocalizationsImplNe extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplNe([String locale = 'ne']) : super(locale);

  @override
  String get creditCardErrorText =>
      'यो क्षेत्रलाई मान्य क्रेडिट कार्ड नम्बर चाहिन्छ।';

  @override
  String get dateStringErrorText =>
      'यो क्षेत्रलाई मान्य मिति स्ट्रिंग चाहिन्छ।';

  @override
  String get emailErrorText => 'यो क्षेत्रलाई मान्य इमेल ठेगाना चाहिन्छ।';

  @override
  String equalErrorText(Object value) {
    return 'यो क्षेत्रको मान $value बराबर हुनुपर्छ। ';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'मानको $length बराबर लम्बाइ हुनुपर्छ।';
  }

  @override
  String get integerErrorText => 'यो क्षेत्रलाई मान्य पूर्णांक चाहिन्छ।';

  @override
  String get ipErrorText => 'यो क्षेत्रलाई मान्य आईपी चाहिन्छ।';

  @override
  String get matchErrorText => 'मान ढाँचासँग मेल खाँदैन।';

  @override
  String maxErrorText(Object max) {
    return 'मान $max भन्दा कम वा बराबर हुनुपर्छ। ';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'मान लम्बाइ $maxLength भन्दा कम वा बराबर हुनुपर्छ। ';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'मानसँग एक शब्दहरूको एक शब्दहरूमा $maxWordsCount भन्दा कम वा बराबर गणना हुनुपर्दछ';
  }

  @override
  String minErrorText(Object min) {
    return 'मान $min भन्दा बढी वा बराबर हुनुपर्छ।';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'मानको लम्बाइ $minLength भन्दा बढी वा बराबर हुनुपर्छ। ';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'मानसँग एक शब्दहरूको गणना गरिएको छ वा बराबर $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'यो क्षेत्रको मान $value बराबर हुनु हुँदैन।';
  }

  @override
  String get numericErrorText => 'मान संख्यात्मक हुनुपर्छ।';

  @override
  String get requiredErrorText => 'यो क्षेत्र खाली हुन सक्दैन।';

  @override
  String get urlErrorText => 'यो फिल्डलाई मान्य यूआरय्ल ठेगाना चाहिन्छ।';
}
