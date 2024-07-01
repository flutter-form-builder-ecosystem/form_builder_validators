import '../../localization/l10n.dart';
import '../base_validator.dart';

class EvenNumberValidator extends BaseValidator<String> {
  const EvenNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.evenNumberErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final int? number = int.tryParse(valueCandidate);
    if (number == null || number.isOdd) {
      return errorText;
    }
    return null;
  }
}
