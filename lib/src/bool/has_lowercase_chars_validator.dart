import '../../localization/l10n.dart';
import '../base_validator.dart';

class HasLowercaseCharsValidator<T> extends BaseValidator<T> {
  HasLowercaseCharsValidator({
    super.errorText,
    super.checkNullOrEmpty,
  });

  @override
  String? validateValue(T? valueCandidate) {
  }
}
