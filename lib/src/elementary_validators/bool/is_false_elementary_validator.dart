import '../../../localization/l10n.dart';
import '../../base_elementary_validator.dart';

/// {@template IsFalseElementaryValidator}
/// This validator returns null if the input value is false and an error message
/// otherwise.
/// {@endtemplate}
final class IsFalseElementaryValidator
    extends BaseElementaryValidator<bool, bool> {
  /// {@macro IsFalseElementaryValidator}
  ///
  /// ## Arguments
  /// - [String?] `errorText`: custom error text provided by the user.
  const IsFalseElementaryValidator({super.errorText});
  @override
  (bool, bool?) transformValueIfValid(bool value) {
    final bool isValid = value == false;
    return (isValid, isValid ? value : null);
  }

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.mustBeFalseErrorText;
}
