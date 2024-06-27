import '../../localization/l10n.dart';
import '../base_validator.dart';

class MatchValidator extends BaseValidator<String> {
  const MatchValidator(
    this.regex, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final RegExp regex;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.matchErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return !regex.hasMatch(valueCandidate!) ? null : errorText;
  }
}
