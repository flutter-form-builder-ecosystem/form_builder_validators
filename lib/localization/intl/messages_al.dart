import 'messages.dart';

/// The translations for Albanian (`al`).
class FormBuilderLocalizationsImplAl extends FormBuilderLocalizationsImpl {
  FormBuilderLocalizationsImplAl([String locale = 'al']) : super(locale);

  @override
  String get requiredErrorText => 'Kjo fushë nuk mund të jetë bosh.';

  @override
  String minErrorText(Object min) {
    return 'Vlera duhet te jete me e madhe ose e barabarte me $min.';
  }

  @override
  String minLengthErrorText(Object minLength) {
    return 'Vlera duhet të ketë një gjatësi më të madhe ose të barabartë me $minLength';
  }

  @override
  String maxErrorText(Object max) {
    return 'Vlera duhet të jetë më e vogël ose e barabartë me $max';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Vlera duhet të ketë një gjatësi më të vogël ose të barabartë me $maxLength';
  }

  @override
  String equalLengthErrorText(Object length) {
    return 'Vlera duhet të ketë nje gjatësi të barabartë me $length';
  }

  @override
  String get emailErrorText => 'Kjo fushe kërkon një adresë e E-mail-i të vlefshëme.';

  @override
  String get integerErrorText => 'Kjo fushe kërkon një numër të plotë të vlefshëm.';

  @override
  String equalErrorText(Object value) {
    return 'Kjo vlerë duhet të jetë e barabartë me $value.';
  }

  @override
  String notEqualErrorText(Object value) {
    return 'Kjo vlerë nuk duhet të jetë e barabartë me $value.';
  }

  @override
  String get urlErrorText => 'Kjo fushe kërkon një adresë URL të vlefshme.';

  @override
  String get matchErrorText => 'Vlera nuk përputhet me shabllonin.';

  @override
  String get numericErrorText => 'Vlera duhet të jetë numerike.';

  @override
  String get creditCardErrorText => 'Kjo fushë kërkon një numër të vlefshëm per karten e kreditit.';

  @override
  String get ipErrorText => 'Kjo fushë kërkon një IP të vlefshme.';

  @override
  String get dateStringErrorText => 'Kjo fushë kërkon një date të vlefshme.';
}
