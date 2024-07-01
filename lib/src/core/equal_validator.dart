import '../../localization/l10n.dart';
import '../base_validator.dart';

class EqualValidator<T> extends BaseValidator<T> {
  const EqualValidator(
    this.value, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final Object value;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.equalErrorText(value);

  @override
  String? validateValue(T valueCandidate) {
    return valueCandidate != value ? errorText : null;
  }
}
