import '../../localization/l10n.dart';
import '../base_validator.dart';

class IntegerValidator extends BaseValidator<String> {
  const IntegerValidator({
    this.radix,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int? radix;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.integerErrorText;

  @override
  String? validateValue(String valueCandidate) {
    final int? number = int.tryParse(valueCandidate, radix: radix);
    if (number == null) {
      return errorText;
    }
    return null;
  }
}
