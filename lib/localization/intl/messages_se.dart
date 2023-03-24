import 'messages.dart';

/// The translations for Northern Sami (`se`).
class FormBuilderLocalizationsImplSe extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplSe([String locale = 'se']) : super(locale);

  @override
  String get requiredErrorText => 'Detta fält får inte vara tomt.';

  @override
  String minErrorText(Object min) {
    return 'Värdet måste vara större än eller lika med $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Värdet måste ha en längd större än eller lika med $minLength.';
  }

  @override
  String minWordsCountErrorText(Object minWordsCount) {
    return 'Värdet måste ha ett antal ord som är större än eller lika med $minWordsCount';
  }

  @override
  String maxErrorText(Object max) {
    return 'Värdet måste vara mindre än eller lika med $max.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Värdet måste ha en längd mindre än eller lika med $maxLength.';
  }

  @override
  String maxWordsCountErrorText(Object maxWordsCount) {
    return 'Värdet måste ha ett antal ord som är mindre än eller lika med $maxWordsCount';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Value must have a length equal to $length';
  }

  @override
  String get emailErrorText => 'Detta fält kräver en giltig e-postadress.';

  @override
  String get integerErrorText => 'Värdet måste vara ett heltal.';

  @override
  String equalErrorText(Object value) {
    return 'Detta fältvärde måste vara lika med $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'This field value must not be equal to $value.';
  }

  @override
  String get urlErrorText => 'Detta fält kräver en giltig URL-adress.';

  @override
  String get matchErrorText => 'Värdet matchar inte mönstret.';

  @override
  String get numericErrorText => 'Värdet måste vara numeriskt.';

  @override
  String get creditCardErrorText => 'Detta fält kräver ett giltigt kreditkortsnummer.';

  @override
  String get ipErrorText => 'Detta fält kräver en giltig IP-adress.';

  @override
  String get dateStringErrorText => 'Detta fält kräver ett giltigt datum.';
}
