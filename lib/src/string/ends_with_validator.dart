import '../../localization/l10n.dart';
import '../base_validator.dart';

class EndsWithValidator extends BaseValidator<String> {
  const EndsWithValidator(
    this.suffix, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final String suffix;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.endsWithErrorText(suffix);

  @override
  String? validateValue(String valueCandidate) {
    return valueCandidate.endsWith(suffix) ? null : errorText;
  }
}
