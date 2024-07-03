import '../../localization/l10n.dart';
import '../base_validator.dart';

class CreditCardCvcValidator extends BaseValidator<String> {
  const CreditCardCvcValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.creditCardCVCErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final int? cvc = int.tryParse(valueCandidate);
    if (cvc == null || valueCandidate.length < 3 || valueCandidate.length > 4) {
      return errorText;
    }
    return null;
  }
}
