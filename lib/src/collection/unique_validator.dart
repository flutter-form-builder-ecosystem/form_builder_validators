import '../../localization/l10n.dart';
import '../base_validator.dart';

class UniqueValidator<T> extends BaseValidator<T> {
  const UniqueValidator(
    this.values, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final List<T> values;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.uniqueErrorText;

  @override
  String? validateValue(T? valueCandidate) {
    return values.where((T element) => element == valueCandidate).length != 1
        ? errorText
        : null;
  }
}
