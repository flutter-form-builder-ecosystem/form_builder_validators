import '../../localization/l10n.dart';
import '../../localization/profanity/profanity.dart';
import '../base_validator.dart';

/// {@template profanity_validator_template}
/// [ProfanityValidator] extends [BaseValidator] to validate if a string contains profanity.
///
/// This validator checks if the value is in the list of disallowed profanity words.
///
/// ## Parameters:
///
/// - [profanityList] An optional list of disallowed profanity.
/// - [errorText] The error message returned if the validation fails.
/// - [checkNullOrEmpty] Whether to check if the value is null or empty.
///
/// {@endtemplate}
class ProfanityValidator extends BaseValidator<String> {
  /// Constructor for the profanity validator.
  ProfanityValidator({
    List<String>? profanityList,
    this.useAllLocales = false,
    super.errorText,
    super.checkNullOrEmpty,
  })  : customErrorText = errorText,
        profanityList = profanityList ??
            (useAllLocales
                ? Profanity.profanityListAll()
                : Profanity.of(FormBuilderLocalizations.current.localeName)
                    .profanityList);

  /// An optional list of disallowed profanity.
  final List<String> profanityList;

  /// Whether to use all locales to check for profanity.
  final bool useAllLocales;

  /// The custom error message returned if the value is invalid.
  final String? customErrorText;

  @override
  String get translatedErrorText => FormBuilderLocalizations.current
      .profanityErrorText(profanityList.join(', '));

  @override
  String? validateValue(String valueCandidate) {
    final List<String> profanityFound = profanityAllFound(valueCandidate);
    if (profanityFound.isNotEmpty) {
      return customErrorText ??
          FormBuilderLocalizations.current
              .profanityErrorText(profanityFound.join(', '));
    }

    return null;
  }

  /// Returns a list of profanity words found in the value.
  List<String> profanityAllFound(String valueCandidate) {
    final RegExp regExp = RegExp(r'\b\w+\b');
    final List<String> inputSplit = regExp
        .allMatches(valueCandidate)
        .map((RegExpMatch match) => match.group(0)!.toLowerCase())
        .toList();

    List<String> profanityFound = <String>[];
    for (String word in profanityList) {
      if (inputSplit.contains(word.toLowerCase())) {
        profanityFound.add(word);
      }
    }
    return profanityFound;
  }

  /// Returns the value with profanity words censored.
  String profanityCensored(String valueCandidate, {String? replaceWith}) {
    final RegExp regExp = RegExp(r'\b\w+\b');
    final Iterable<RegExpMatch> matches = regExp.allMatches(valueCandidate);

    StringBuffer buffer = StringBuffer();
    int lastMatchEnd = 0;

    for (final RegExpMatch match in matches) {
      buffer.write(valueCandidate.substring(lastMatchEnd, match.start));
      String word = match.group(0)!;
      if (profanityList.contains(word.toLowerCase())) {
        buffer.write(replaceWith ?? '*' * word.length);
      } else {
        buffer.write(word);
      }
      lastMatchEnd = match.end;
    }

    buffer.write(valueCandidate.substring(lastMatchEnd));
    return buffer.toString();
  }
}
