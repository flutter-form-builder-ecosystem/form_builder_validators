import '../../localization/l10n.dart';
import '../base_validator.dart';

class ContainsElementValidator<T> extends BaseValidator<T> {
  ContainsElementValidator(
    this.values, {
    super.errorText,
    super.checkNullOrEmpty,
  });

  final List<T> values;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.containsElementErrorText;

  @override
  String? validateValue(T? valueCandidate) {
    return values.contains(valueCandidate) ? null : errorText;
  }
}
