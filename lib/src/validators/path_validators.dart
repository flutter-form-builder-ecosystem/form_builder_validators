import 'package:path/path.dart' as p;

import '../../localization/l10n.dart';
import 'constants.dart';

bool _isValidExtension(String v) => v.isEmpty || v[0] == '.';

/// Expects not empty v
int _numOfExtensionLevels(String v) => r'.'.allMatches(v).length;

/// {@macro validator_matches_allowed_extensions}
Validator<String> matchesAllowedExtensions(
  List<String> extensions, {
  String Function(List<String>)? matchesAllowedExtensionsMsg,
  bool caseSensitive = true,
}) {
  if (extensions.isEmpty) {
    throw ArgumentError.value(
        '[]', 'extensions', 'The list of extensions must not be empty');
  }
  int maxLevel = 1;
  for (final (int i, String ex) in extensions.indexed) {
    if (!_isValidExtension(ex)) {
      throw ArgumentError.value(ex, 'extensions[$i]', 'Invalid extension');
    }
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
