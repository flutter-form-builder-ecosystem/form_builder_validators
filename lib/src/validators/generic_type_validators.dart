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
  // TODO(ArturAssisComp): transform this assertion into an ArgumentError.value call
  assert(values.isNotEmpty, 'The list "values" may not be empty.');
  final Set<T> setOfValues = values.toSet();
  return (T input) {
    return setOfValues.contains(input)
        ? null
        : containsElementMsg?.call(input, values) ??
            FormBuilderLocalizations.current.containsElementErrorText;
  };
}

/// {@template validator_is_true}
/// Creates a validator function that checks if a given input represents a `true`
/// boolean value, either as a direct boolean or as a string that can be parsed
/// to `true`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must extend `Object` to allow for both
/// boolean and string inputs.
///
/// ## Parameters
/// - `isTrueMsg` (`String Function(T input)?`): Optional callback function to
/// generate custom error messages for invalid inputs. Receives the invalid
/// input as a parameter.
/// - `caseSensitive` (`bool`): Controls whether string comparison is
/// case-sensitive. Defaults to `false`, making, for example, 'TRUE' and 'true'
/// equivalent.
/// - `trim` (`bool`): Determines if leading and trailing whitespace should be
/// removed from string inputs before validation. Defaults to `true`.
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if the input is `true` or parses to `true`
/// - Returns an error message if the input is invalid, either from `isTrueMsg`
/// or the default localized text
///
/// ## Examples
/// ```dart
/// // Basic usage with default settings
/// final validator = isTrue<String>();
/// assert(validator('true') == null);      // Valid: case-insensitive match
/// assert(validator(' TRUE ') == null);     // Valid: trimmed and case-insensitive
/// assert(validator('t r u e') != null);      // Invalid: returns error message
/// assert(validator('false') != null);      // Invalid: returns error message
///
/// // Custom configuration
/// final strictValidator = isTrue<String>(
///   caseSensitive: true,
///   trim: false,
///   isTrueMsg: (input) => 'Value "$input" must be exactly "true"',
/// );
/// assert(strictValidator('true') == null);   // Valid
/// assert(strictValidator('TRUE') != null);   // Invalid: case-sensitive
/// assert(strictValidator(' true') != null);  // Invalid: no trimming
/// ```
/// {@endtemplate}
Validator<T> isTrue<T extends Object>(
    {String Function(T input)? isTrueMsg,
    bool caseSensitive = false,
    bool trim = true}) {
  return (T input) {
    final (bool isValid, bool? typeTransformedValue) =
        _isBoolValidateAndConvert(
      input,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (isValid && typeTransformedValue! == true) {
      return null;
    }
    return isTrueMsg?.call(input) ??
        FormBuilderLocalizations.current.mustBeTrueErrorText;
  };
}

/// {@template validator_is_false}
/// Creates a validator function that checks if a given input represents a `false`
/// boolean value, either as a direct boolean or as a string that can be parsed
/// to `false`.
///
/// ## Type Parameters
/// - `T`: The type of input to validate. Must extend `Object` to allow for both
/// boolean and string inputs.
///
/// ## Parameters
/// - `isFalseMsg` (`String Function(T input)?`): Optional callback function to
/// generate custom error messages for invalid inputs. Receives the invalid
/// input as a parameter.
/// - `caseSensitive` (`bool`): Controls whether string comparison is
/// case-sensitive. Defaults to `false`, making, for example, 'FALSE' and 'false'
/// equivalent.
/// - `trim` (`bool`): Determines if leading and trailing whitespace should be
/// removed from string inputs before validation. Defaults to `true`.
///
/// ## Returns
/// Returns a `Validator<T>` function that:
/// - Returns `null` if the input is `false` or parses to `false`
/// - Returns an error message if the input is invalid, either from `isFalseMsg`
/// or the default localized text
///
/// ## Examples
/// ```dart
/// // Basic usage with default settings
/// final validator = isFalse<String>();
/// assert(validator('false') == null);     // Valid: case-insensitive match
/// assert(validator(' FALSE ') == null);    // Valid: trimmed and case-insensitive
/// assert(validator('f a l s e') != null); // Invalid: returns error message
/// assert(validator('true') != null);      // Invalid: returns error message
///
/// // Custom configuration
/// final strictValidator = isFalse<String>(
///   caseSensitive: true,
///   trim: false,
///   isFalseMsg: (input) => 'Value "$input" must be exactly "false"',
/// );
/// assert(strictValidator('false') == null);  // Valid
/// assert(strictValidator('FALSE') != null);  // Invalid: case-sensitive
/// assert(strictValidator(' false') != null); // Invalid: no trimming
/// ```
/// {@endtemplate}
Validator<T> isFalse<T extends Object>(
    {String Function(T input)? isFalseMsg,
    bool caseSensitive = false,
    bool trim = true}) {
  return (T input) {
    final (bool isValid, bool? typeTransformedValue) =
        _isBoolValidateAndConvert(
      input,
      caseSensitive: caseSensitive,
      trim: trim,
    );
    if (isValid && typeTransformedValue! == false) {
      return null;
    }
    return isFalseMsg?.call(input) ??
        FormBuilderLocalizations.current.mustBeFalseErrorText;
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
