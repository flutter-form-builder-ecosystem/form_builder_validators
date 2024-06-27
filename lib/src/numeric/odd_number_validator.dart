import '../../localization/l10n.dart';
import '../base_validator.dart';

class OddNumberValidator extends BaseValidator<String> {
  OddNumberValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.oddNumberErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final int? number = int.tryParse(valueCandidate);
    if (number == null || number.isEven) {
      return errorText;
    }
    return null;
  }
}
