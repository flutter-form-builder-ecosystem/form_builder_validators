import '../../localization/l10n.dart';
import '../base_validator.dart';

class StartsWithValidator extends BaseValidator<String> {
  const StartsWithValidator(
    this.prefix, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final String prefix;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.startsWithErrorText(prefix);

  @override
  String? validateValue(String valueCandidate) {
    return valueCandidate.startsWith(prefix) ? null : errorText;
  }
}
