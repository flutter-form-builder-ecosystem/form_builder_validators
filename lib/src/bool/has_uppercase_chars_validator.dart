import '../../localization/l10n.dart';
import '../base_validator.dart';

class HasUppercaseCharsValidator<T> extends BaseValidator<T> {
  HasUppercaseCharsValidator({
    super.errorText,
    super.checkNullOrEmpty,
  });

  @override
  String? validateValue(T? valueCandidate) {
  }
}
