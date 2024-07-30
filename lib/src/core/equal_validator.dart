import '../../localization/l10n.dart';
import '../base_validator.dart';

/// {@template equal_validator_template}
/// [EqualValidator] extends [BaseValidator] to validate if a value is equal to a specified value.
///
/// ## Parameters:
///
/// - [value] The value to compare against.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class EqualValidator<T> extends BaseValidator<T> {
  /// Constructor for the equal value validator.
  const EqualValidator(
    this.value, {
    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  /// The value to compare against.
  final Object value;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.equalErrorText(value.toString());

  @override
  String? validateValue(T valueCandidate) {
    return valueCandidate != value ? errorText : null;
  }
}
