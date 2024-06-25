import '../../localization/l10n.dart';
import '../base_validator.dart';

class IsFalseValidator extends BaseValidator<bool> {
  const IsFalseValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.mustBeFalseErrorText;

  @override
  String? validateValue(bool? valueCandidate) {
    return valueCandidate ?? false ? null : errorText;
  }
}
