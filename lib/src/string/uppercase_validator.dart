import '../../localization/l10n.dart';
import '../base_validator.dart';

class UppercaseValidator extends BaseValidator<String> {
  const UppercaseValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.uppercaseErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return valueCandidate!.toUpperCase() == valueCandidate ? null : errorText;
  }
}
