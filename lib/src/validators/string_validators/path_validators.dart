import 'package:path/path.dart' as p;

import '../../../localization/l10n.dart';
import '../constants.dart';

bool _isValidExtension(String v) => v.isEmpty || v[0] == '.';

/// Expects not empty v
int _numOfExtensionLevels(String v) => r'.'.allMatches(v).length;

/// {@template validator_matches_allowed_extensions}
/// A validator function that checks if a file path's extension matches any of
/// the specified allowed extensions. Returns `null` for valid extensions, or an
/// error message for invalid ones.
///
/// The validator supports both single-level (e.g., '.txt') and multi-level
/// (e.g., '.tar.gz') extensions, with configurable case sensitivity.
///
/// ## Parameters
/// - `extensions` (`List<String>`): List of valid file extensions. Each extension must start
///   with a dot (e.g., '.pdf', '.tar.gz'). Empty string is considered a valid extension
/// - `matchesAllowedExtensionsMsg` (`String Function(List<String>)?`): Optional custom error
///   message generator. Receives the list of allowed extensions and returns an error message
/// - `caseSensitive` (`bool`): Controls whether extension matching is case-sensitive.
///   Defaults to `true`
///
/// ## Returns
/// Returns a `Validator<String>` function that:
/// - Returns `null` if the input path's extension matches any allowed extension
/// - Returns an error message (custom or default) if no extension match is found
///
/// ## Throws
/// - `AssertionError`: When `extensions` list is empty
/// - `AssertionError`: When any extension in `extensions` doesn't start with a dot
///   (except for empty string)
///
/// ## Examples
/// ```dart
/// // Single-level extension validation
/// final validator = matchesAllowedExtensions(['.pdf', '.doc']);
/// print(validator('document.pdf')); // Returns: null
/// print(validator('document.txt')); // Returns: error message
///
/// // Multi-level extension validation
/// final archiveValidator = matchesAllowedExtensions(['.tar.gz', '.zip']);
/// print(archiveValidator('archive.tar.gz')); // Returns: null
///
/// // Case-insensitive validation
/// final caseValidator = matchesAllowedExtensions(
///   ['.PDF', '.DOC'],
///   caseSensitive: false
/// );
/// print(caseValidator('document.pdf')); // Returns: null
/// ```
///
/// ## Caveats
/// - Extensions must explicitly include the leading dot (use '.txt' not 'txt')
/// {@endtemplate}
Validator<String> matchesAllowedExtensions(
  List<String> extensions, {
  String Function(List<String>)? matchesAllowedExtensionsMsg,
  bool caseSensitive = true,
}) {
  assert(extensions.isNotEmpty, 'allowed extensions may not be empty.');
  int maxLevel = 1;
  for (final String ex in extensions) {
    assert(_isValidExtension(ex), 'Invalid extension: $ex');
    final int currentLevel = _numOfExtensionLevels(ex);
    if (currentLevel > maxLevel) {
      maxLevel = currentLevel;
    }
  }
  Set<String> extensionsSet = <String>{};
  if (caseSensitive) {
    extensionsSet.addAll(extensions);
  } else {
    for (final String extension in extensions) {
      extensionsSet.add(extension.toLowerCase());
    }
  }
  return (String input) {
    final String finalInput = caseSensitive ? input : input.toLowerCase();
    final String firstLevelExtension = p.extension(finalInput);
    final Set<String> extensionsFromUserInput = <String>{firstLevelExtension};

    if (firstLevelExtension.isNotEmpty) {
      for (int i = 1; i < maxLevel; i++) {
        final String extension = p.extension(finalInput, i + 1);
        extensionsFromUserInput.add(extension);
      }
    }
    return extensionsFromUserInput.intersection(extensionsSet).isNotEmpty
        ? null
        : matchesAllowedExtensionsMsg?.call(extensions) ??
            FormBuilderLocalizations.current.fileExtensionErrorText(
              extensions.join(', '),
            );
  };
}
