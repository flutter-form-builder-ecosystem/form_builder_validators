import '../../localization/l10n.dart';
import '../base_validator.dart';

class RequiredValidator<T> extends BaseValidator<T> {
  const RequiredValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.requiredErrorText;

  @override
  String? validateValue(T valueCandidate) {
    // BaseValidator<T> will already check for null values
    return null;
  }
}
