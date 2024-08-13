import '../../../localization/l10n.dart';
import '../../elementary_validator.dart';

/// {@template IsTrueElementaryValidator}
/// This validator returns null if the input value is true and an error message
/// otherwise.
/// {@endtemplate}
final class IsTrueElementaryValidator
    extends BaseElementaryValidator<bool, bool> {
  /// {@macro IsTrueElementaryValidator}
  ///
  /// ## Arguments
  /// - [String?] `errorText`: custom error text provided by the user.
  const IsTrueElementaryValidator({super.errorText});
  @override
  (bool, bool?) transformValueIfValid(bool value) {
    final bool isValid = value == true;
    return (isValid, isValid ? value : null);
  }

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.mustBeTrueErrorText;
}
