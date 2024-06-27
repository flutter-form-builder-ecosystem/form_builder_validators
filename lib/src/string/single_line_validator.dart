import '../../localization/l10n.dart';
import '../base_validator.dart';

class SingleLineValidator extends BaseValidator<String> {
  const SingleLineValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.singleLineErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    return !valueCandidate!.contains('\n') && !valueCandidate.contains('\r')
        ? errorText
        : null;
  }
}
