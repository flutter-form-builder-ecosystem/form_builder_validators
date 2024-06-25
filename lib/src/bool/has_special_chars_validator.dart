import '../../localization/l10n.dart';
import '../base_validator.dart';

class HasSpecialCharsValidator<T> extends BaseValidator<T> {
  HasSpecialCharsValidator({
    super.errorText,
    super.checkNullOrEmpty,
  });

  @override
  String? validateValue(T? valueCandidate) {
  }
}
