import '../../../localization/l10n.dart';
import '../../base_elementary_validator.dart';

/// {@template max_elementary_validator}
/// Validate if a value is less than or equal to a specified maximum value.
///
/// ## Parameters:
///
/// - [max] The maximum allowable value.
/// - [inclusive] Whether the maximum value is inclusive. Defaults to true.
/// - [errorText] The error message returned if the validation fails.
/// {@endtemplate}
final class MaxElementaryValidator<T extends num>
    extends BaseElementaryValidator<T, T> {
  /// {@macro max_elementary_validator}
  const MaxElementaryValidator(
    this.max, {
    this.inclusive = true,
    super.errorText,
  }) : super(ignoreErrorMessage: false);

  /// The maximum allowable value.
  final num max;

  /// Whether the maximum value is inclusive.
  final bool inclusive;

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.maxErrorText(max);

  @override
  (bool, T?) transformValueIfValid(T value) {
    if (value < max) {
      return (true, value);
    }
    if (value > max) {
      return (false, null);
    }
    if (inclusive) {
      return (true, value);
    }
    return (false, null);
  }
}
