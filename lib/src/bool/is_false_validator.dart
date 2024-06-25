import '../../localization/l10n.dart';
import '../base_validator.dart';

class IsFalseValidator<T> extends BaseValidator<T> {
  IsFalseValidator({
    String? errorText,
    bool checkNullOrEmpty = false,
  });

  @override
  String? validateValue(T? valueCandidate) {
  }
}