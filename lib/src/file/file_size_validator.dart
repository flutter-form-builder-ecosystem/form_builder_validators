import 'dart:math';

import 'package:intl/intl.dart';

import '../../localization/l10n.dart';
import '../base_validator.dart';

class FileSizeValidator extends BaseValidator<String> {
  const FileSizeValidator(
    this.maxSize, {
    this.base1024Conversion = true,

    /// {@macro base_validator_error_text}
    super.errorText,

    /// {@macro base_validator_null_check}
    super.checkNullOrEmpty,
  });

  final int maxSize;

  /// Whether to use base 1024 (true) or base 1000 (false) for the conversion.
  final bool base1024Conversion;

  @override
  String get translatedErrorText => FormBuilderLocalizations.current
      .fileSizeErrorText(formatBytes(0), formatBytes(maxSize));

  @override
  String? validateValue(String valueCandidate) {
    final int? size = int.tryParse(valueCandidate);
    if (size == null || size > maxSize) {
      return errorText;
    }
    return null;
  }

  /// Helper function to format bytes into a human-readable string (e.g., KB, MB, GB).
  String formatBytes(int bytes) {
    double log10(num x) => log(x) / ln10;

    if (bytes <= 0) return '0 B';

    final int base = base1024Conversion ? 1024 : 1000;
    final List<String> units = base1024Conversion
        ? <String>['B', 'KiB', 'MiB', 'GiB', 'TiB']
        : <String>['B', 'kB', 'MB', 'GB', 'TB'];

    final int digitGroups = (log10(bytes) / log10(base)).floor();
    final double size = bytes / pow(base, digitGroups);

    return "${NumberFormat("#,##0.#").format(size)} ${units[digitGroups]}";
  }
}
