import '../../localization/l10n.dart';
import '../base_validator.dart';

class DateValidator extends BaseValidator<String> {
  const DateValidator({
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.dateStringErrorText;

  @override
  String? validateValue(String? valueCandidate) {
    final DateTime? date = DateTime.tryParse(valueCandidate!);
    if (date == null) {
      return errorText;
    }

    return null;
  }
}
