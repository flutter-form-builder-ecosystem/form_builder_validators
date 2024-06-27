import '../../localization/l10n.dart';
import '../base_validator.dart';

class LowercaseValidator extends BaseValidator<String> {
  const LowercaseValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.lowercaseErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return valueCandidate!.toLowerCase() == valueCandidate ? null : errorText;
  }
}
