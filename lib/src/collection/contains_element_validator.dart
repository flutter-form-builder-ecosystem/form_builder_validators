import '../../localization/l10n.dart';
import '../base_validator.dart';

class ContainsElementValidator<T> extends BaseValidator<T> {
  const ContainsElementValidator(
    this.values, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final List<T> values;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsElementErrorText;

  @override
  String? validateValue(T valueCandidate) {
    return values.contains(valueCandidate) ? null : errorText;
  }
}
