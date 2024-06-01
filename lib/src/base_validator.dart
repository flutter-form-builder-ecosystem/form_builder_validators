/// Base class for all validators.
abstract class BaseValidator<T> {
  /// {@template base_validator_error_text}
  /// The error message returned if the value is invalid.
  /// {@endtemplate}
  final String errorText;

  const BaseValidator({required this.errorText});

  /// Validates the given value.
  String? validate(T? valueCandidate);

  /// Checks if the given value is valid on basics:
  ///
  /// - If the value is `null`.
  /// - If the value is a `String`, `Iterable`, or `Map` and is empty.
  /// - If the value passes the custom validation made by `validate`.
  ///
  /// Returns the error message if the value is invalid.
  String? call(T? valueCandidate) {
    if (valueCandidate == null ||
        (valueCandidate is String && valueCandidate.trim().isEmpty) ||
        (valueCandidate is Iterable && valueCandidate.isEmpty) ||
        (valueCandidate is Map && valueCandidate.isEmpty)) {
      return errorText;
    }
    return validate(valueCandidate);
  }
}
