import '../../localization/l10n.dart';
import 'constants.dart';

/// {@template validator_contains_element}
/// Creates a validator function that verifies if a given input is in `values`.
///
/// ## Type Parameters
/// - `T`: The type of elements to validate. Must extend Object?, allowing nullable
/// types.
///
/// ## Parameters
/// - `values` (`List<T>`): A non-empty list of valid values to check against. The input
///   will be validated against these values.
/// - `containsElementMsg` (`String Function(T input, List<T> values)?`): Optional callback
///   function that generates a custom error message when validation fails. The function
///   receives the invalid input and the list of valid values as parameters. If not provided,
///   defaults to the localized error text from FormBuilderLocalizations.
///
/// ## Returns
/// Returns a `Validator<T>`  function that:
/// - Returns null if the input value exists in the provided list
/// - Returns a generated error message if the input is not found in the list.
///
/// ## Throws
/// - `AssertionError`: Thrown if the provided values list is empty, which would
/// make any input invalid.
///
/// ## Examples
/// ```dart
/// // Creating a validator with a custom error message generator
/// final countryValidator = containsElement(
///   ['USA', 'Canada', 'Mexico'],
///   containsElementMsg: (input, values) =>
///     'Country $input is not in allowed list: ${values.join(", ")}',
/// );
///
/// // Using the validator
/// final result = countryValidator('Brazil'); // Returns "Country Brazil is not in allowed list: USA, Canada, Mexico"
/// final valid = countryValidator('USA');     // Returns null (valid)
/// ```
/// {@endtemplate}
Validator<T> containsElement<T extends Object?>(
  List<T> values, {
  String Function(T input, List<T> values)? containsElementMsg,
}) {
  assert(values.isNotEmpty, 'The list "values" may not be empty.');
  final Set<T> setOfValues = values.toSet();
  return (T input) {
    return setOfValues.contains(input)
        ? null
        : containsElementMsg?.call(input, values) ??
            FormBuilderLocalizations.current.containsElementErrorText;
  };
}

/// Returns a [Validator] function that checks if its `T` input is a `true`
/// boolean or a [String] parsable to a `true` boolean. If the input satisfies
/// this condition, the validator returns `null`. Otherwise, it returns the
/// default error message
/// `FormBuilderLocalizations.current.mustBeTrueErrorText`, if [isTrueMsg]
/// is not provided.
///
/// # Parsing rules
/// If the input of the validator is a [String], it will be parsed using
/// the rules specified by the combination of [caseSensitive] and [trim].
/// [caseSensitive] indicates whether the lowercase must be considered equal to
/// uppercase or not, and [trim] indicates whether whitespaces from both sides
/// of the string will be ignored or not.
///
/// The default behavior is to ignore leading and trailing whitespaces and be
/// case insensitive.
///
/// # Examples
/// ```dart
/// // The following examples must pass:
/// assert(isTrue()(' true ') == null);
/// assert(isTrue(trim:false)(' true ') != null);
/// assert(isTrue()('TRue') == null);
/// assert(isTrue(caseSensitive:true)('TRue') != null);
/// ```
Validator<T> isTrue<T extends Object>(
    {String? isTrueMsg, bool caseSensitive = false, bool trim = true}) {
  return (T value) {
    final (bool isValid, bool? typeTransformedValue) =
        _isBoolValidateAndConvert(
      value,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (isValid && typeTransformedValue! == true) {
      return null;
    }
    return isTrueMsg ?? FormBuilderLocalizations.current.mustBeTrueErrorText;
  };
}

/// Returns a [Validator] function that checks if its `T` input is a `false`
/// boolean or a [String] parsable to a `false` boolean. If the input satisfies
/// this condition, the validator returns `null`. Otherwise, it returns the
/// default error message
/// `FormBuilderLocalizations.current.mustBeFalseErrorText`, if [isFalseMsg]
/// is not provided.
///
/// # Parsing rules
/// If the input of the validator is a [String], it will be parsed using
/// the rules specified by the combination of [caseSensitive] and [trim].
/// [caseSensitive] indicates whether the lowercase must be considered equal to
/// uppercase or not, and [trim] indicates whether whitespaces from both sides
/// of the string will be ignored or not.
///
/// The default behavior is to ignore leading and trailing whitespaces and be
/// case insensitive.
///
/// # Examples
/// ```dart
/// // The following examples must pass:
/// assert(isFalse()(' false ') == null);
/// assert(isFalse(trim:false)(' false ') != null);
/// assert(isFalse()('FAlse') == null);
/// assert(isFalse(caseSensitive:true)('FAlse') != null);
/// ```
Validator<T> isFalse<T extends Object>(
    {String? isFalseMsg, bool caseSensitive = false, bool trim = true}) {
  return (T value) {
    final (bool isValid, bool? typeTransformedValue) =
        _isBoolValidateAndConvert(
      value,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (isValid && typeTransformedValue! == false) {
      return null;
    }
    return isFalseMsg ?? FormBuilderLocalizations.current.mustBeFalseErrorText;
  };
}

(bool, bool?) _isBoolValidateAndConvert<T extends Object>(T value,
    {bool caseSensitive = false, bool trim = true}) {
  if (value is bool) {
    return (true, value);
  }
  if (value is String) {
    final bool? candidateValue = bool.tryParse(trim ? value.trim() : value,
        caseSensitive: caseSensitive);
    if (candidateValue != null) {
      return (true, candidateValue);
    }
  }
  return (false, null);
}
