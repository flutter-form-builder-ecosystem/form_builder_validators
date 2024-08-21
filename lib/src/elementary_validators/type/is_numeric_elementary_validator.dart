import '../../../localization/l10n.dart';
import '../../base_elementary_validator.dart';

/// {@template is_required_elementary_validator}
/// This validator checks if the user input value has numeric (num) type.
///
/// ## Parameters
/// - [errorText] The error message returned if the validation fails.
/// - [withAndComposition] List of elementary validators that will be executed if this
/// validator passes.
/// - [otherwise] List of elementary validators that will be executed if this
/// validator fails. They are alternative validation in case this fails.
/// {@endtemplate}
final class IsNumericElementaryValidator<T extends Object>
    extends BaseElementaryValidator<T, num> {
  /// {@macro is_required_elementary_validator}
  const IsNumericElementaryValidator({
    super.ignoreErrorMessage = false,
    super.errorText,
    super.withAndComposition,
    super.withOrComposition,
    super.otherwise,
  });

  @override
  (bool, num?) transformValueIfValid(T value) {
    if (value is num) {
      return (true, value);
    }
    if (value is String) {
      final num? candidateValue = num.tryParse(value);
      if (candidateValue != null) {
        return (true, candidateValue);
      }
    }
    return (false, null);
  }

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.numericErrorText;
}
