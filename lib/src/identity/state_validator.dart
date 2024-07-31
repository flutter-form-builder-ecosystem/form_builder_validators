import '../../form_builder_validators.dart';

/// {@template state_validator_template}
/// [StateValidator] extends [TranslatedValidator] to validate if a string represents a valid state name.
///
/// This validator checks if the state name matches a specified regex pattern and is not in a blacklist,
/// and optionally checks if it is in a whitelist.
///
/// ## Parameters:
///
/// - [regex] The regular expression used to validate the state name format. Defaults to a standard state name regex.
/// - [stateWhitelist] A list of valid state names that are explicitly allowed.
/// - [stateBlacklist] A list of invalid state names that are explicitly disallowed.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class StateValidator extends TranslatedValidator<String> {
  /// Constructor for the state name validator.
  StateValidator({
    /// {@macro state_template}
    RegExp? regex,
    this.stateWhitelist = const <String>[],
    this.stateBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _state;

  /// The regular expression used to validate the state name format.
  final RegExp regex;

  /// A list of valid state names that are explicitly allowed.
  final List<String> stateWhitelist;

  /// A list of invalid state names that are explicitly disallowed.
  final List<String> stateBlacklist;

  /// {@template state_template}
  /// This regex matches a valid state name format.
  ///
  /// - It requires the first letter to be uppercase.
  /// - It allows only alphabetic characters and spaces.
  ///
  /// Examples: California, New York, Texas
  /// {@endtemplate}
  static final RegExp _state = RegExp(r'^[A-Z][a-zA-Z\s]+$');

  @override
  String get translatedErrorText =>
      FormBuilderLocalizations.current.stateErrorText;

  @override
  String? validateValue(String valueCandidate) {
    if (stateBlacklist.contains(valueCandidate)) {
      return errorText;
    }

    if (!regex.hasMatch(valueCandidate)) {
      return errorText;
    }

    if (stateWhitelist.isEmpty || stateWhitelist.contains(valueCandidate)) {
      return null;
    }

    return errorText;
  }
}
