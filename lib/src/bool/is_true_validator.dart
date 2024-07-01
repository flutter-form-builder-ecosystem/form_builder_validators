import '../../localization/l10n.dart';
import '../base_validator.dart';

class IsTrueValidator extends BaseValidator<bool> {
  const IsTrueValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.mustBeTrueErrorText;

  @override
  String? validateValue(bool valueCandidate) {
    return valueCandidate == true ? null : errorText;
  }
}
