import '../../localization/l10n.dart';
import '../base_validator.dart';

class ContainsValidator extends BaseValidator<String> {
  const ContainsValidator(
    this.substring, {
    this.caseSensitive = true,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final String substring;

  final bool caseSensitive;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsErrorText(substring);

  @override
  String? validateValue(String valueCandidate) {
    if (caseSensitive) {
      return valueCandidate.contains(substring) ? null : errorText;
    } else {
      return valueCandidate.toLowerCase().contains(substring.toLowerCase())
          ? null
          : errorText;
    }
  }
}
