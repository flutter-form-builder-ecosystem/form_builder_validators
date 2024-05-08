import 'messages.dart';

/// The translations for Estonian (`et`).
class FormBuilderLocalizationsImplEt extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplEt([String locale = 'et']) : super(locale);

  @override
  String get creditCardErrorText =>
      'Sellele väljale tuleb sisestada korrektne krediitkaardi number.';

  @override
  String get dateStringErrorText =>
      'Sellele väljale tuleb sisestada korrektne kuupäev.';

  @override
  String get emailErrorText => 'See väli nõuab kehtivat e-posti aadressi.';

  @override
  String equalErrorText(Object value) {
    return 'See väärtus peab olema $value.';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Väärtuse pikkus peab olema võrdne $length';
  }

  @override
  String get integerErrorText => 'Sisend peab olema täisarv.';

  @override
  String get ipErrorText =>
      'Sellele väljale tuleb sisestada korrektne IP-aadress.';

  @override
  String get matchErrorText => 'Sisend ei vasta mustrile.';

  @override
  String maxErrorText(Object max) {
    return 'Väärtus ei tohi olla üle $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Sisendi pikkus ei tohi olla üle $maxLength';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Väärtuses peab olema sõnade arv vähem või võrdne $maxWordsCount';
  }

  @override
  String minErrorText(Object min) {
    return 'Väärtus peab olema vähemalt $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Sisendi pikkus peab olema vähemalt $minLength';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Väärtuse sõnade arv peab olema suurem kui $minWordsCount';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'See väärtus ei tohi olla $value.';
  }

  @override
  String get numericErrorText => 'Sisend peab olema arv.';

  @override
  String get requiredErrorText => 'See väli ei tohi olla tühi.';

  @override
  String get urlErrorText => 'Sellele väljale tuleb sisestada korrektne URL.';
}
