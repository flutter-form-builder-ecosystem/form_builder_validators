import '../../localization/l10n.dart';
import '../base_validator.dart';

class HasNumericCharsValidator<T> extends BaseValidator<T> {
  HasNumericCharsValidator({
    super.errorText,
    super.checkNullOrEmpty,
  });

  @override
  String? validateValue(T? valueCandidate) {
  }
}