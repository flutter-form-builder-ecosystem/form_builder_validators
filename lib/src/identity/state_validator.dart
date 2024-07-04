import '../../localization/l10n.dart';
import '../base_validator.dart';

class StateValidator extends BaseValidator<String> {
  StateValidator({
    /// {@macro state_template}
    RegExp? regex,
    this.stateWhitelist = const <String>[],
    this.stateBlacklist = const <String>[],
    super.errorText,
    super.checkNullOrEmpty,
  }) : regex = regex ?? _state;

  final RegExp regex;

  final List<String> stateWhitelist;

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
