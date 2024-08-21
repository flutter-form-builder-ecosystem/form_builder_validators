import '../../base_elementary_validator.dart';

/// {@template is_not_required_elementary_validator}
/// This validator checks if a value was not provided. On the validation
/// process, if a non-empty value is provided, it triggers the [otherwise]
/// conditions. If all of them fails, it returns an error message, otherwise, it
/// returns null.
///
/// ## Parameters
/// - [errorText] The error message returned if the validation fails.
/// - [withAndComposition] List of elementary validators that will be executed if this
/// validator passes.
/// - [otherwise] List of elementary validators that will be executed if this
/// validator fails. They are alternative validation in case this fails.
/// {@endtemplate}
final class IsNotRequiredElementaryValidator<T extends Object>
    extends BaseElementaryValidator<T?, T?> {
  /// {@macro is_not_required_elementary_validator}
  const IsNotRequiredElementaryValidator({
    super.errorText,
    super.withAndComposition,
    super.withOrComposition,
    super.otherwise,
  }) : super(ignoreErrorMessage: true);

  @override
  (bool, T?) transformValueIfValid(T? value) {
    if (value == null &&
        (value is String && value.trim().isEmpty) &&
        (value is Iterable && value.isEmpty) &&
        (value is Map && value.isEmpty)) {
      return (true, value);
    }
    return (false, null);
  }

  @override
  String get translatedErrorText => '';
}
