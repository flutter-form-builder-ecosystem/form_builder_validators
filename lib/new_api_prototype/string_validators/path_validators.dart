import 'package:path/path.dart' as p;

import '../../localization/l10n.dart';
import '../constants.dart';

bool _isValidExtension(String v) => v.isEmpty || v[0] == '.';

/// Expects not empty v
int _numOfExtensionLevels(String v) => r'.'.allMatches(v).length;

/// This function returns a validator that checks if the user input path has an
/// extension that matches at least one element from `extensions`. If a match
/// happens, the validator returns `null`, otherwise, it returns
/// `matchesAllowedExtensionsMsg`, if it is provided, or
/// [FormBuilderLocalizations.current.fileExtensionErrorText], if not.
///
/// ## Parameters
/// - `extensions`: a list of valid allowed extensions. An extension must be started
/// by a dot. Check for examples in the `Errors` section.
/// - `caseSensitive`: whether the match is case sensitive.
///
/// ## Errors
/// - Throws [AssertionError] when `extensions` is empty.
/// - Throws [AssertionError] when an extension from `extensions` is neither
/// empty nor initiated by dot.
///   - Examples of valid extensions: '.exe', '', '.a.b.c', '.', '..'.
///   - Examples of invalid extensions: 'invalid.extension', 'abc', 'a.b.c.'.
///
/// ## Caveats
/// - Remember, extensions must start with a trailing dot. Thus, instead
/// of 'txt', type '.txt'.
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
