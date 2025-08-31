import 'dart:math';

import 'package:intl/intl.dart';

import '../../localization/l10n.dart';
import 'constants.dart';

/// Defines the unit systems used for file size calculations and representations.
///
/// This enum provides two common standards for representing file sizes:
/// - 1000-based units (B, kB, MB, GB, TB) where 1 kilobyte = 1000 bytes
/// - 1024-based units (B, KiB, MiB, GiB, TiB) where 1 kibibyte = 1024 bytes
///
/// ## Examples
/// ```dart
/// // Format 1_500_000 bytes using the 1000-based system
/// final readableSize = formatBytes(1_500_000, Base.b1000); // "1.5 MB"
///
/// // Format 1_500_000 bytes using the 1024-based system
/// final readableSize = formatBytes(1_500_000, Base.b1024); // "1.46 MiB"
/// ```
enum Base {
  /// 1KB is equivalent to 10^3 = 1000 B
  b1000(1000, <String>['B', 'KB', 'MB', 'GB', 'TB']),

  /// 1KiB is equivalent to 2^10 = 1024 B
  b1024(1024, <String>['B', 'KiB', 'MiB', 'GiB', 'TiB']);

  /// The number of bytes in one 'kilo' unit.
  final int base;

  /// The units available for the current base.
  List<String> get units => List<String>.unmodifiable(_units);
  final List<String> _units;

  const Base(this.base, this._units);
}

/// {@macro validator_max_file_size}
Validator<int> maxFileSize(
  int max, {
  Base base = Base.b1024,
  String Function(int input, int max, Base base)? maxFileSizeMsg,
}) {
  return (int input) {
    if (input <= max) {
      return null;
    }
    if (maxFileSizeMsg != null) {
      return maxFileSizeMsg(input, max, base);
    }

    final (String formattedMax, String formattedInput) = formatBoth(
      max,
      input,
      base,
    );

    return FormBuilderLocalizations.current.fileSizeErrorText(
      formattedMax,
      formattedInput,
    );
  };
}

/// Helper function to format bytes into a human-readable string (e.g., KB, MB, GB)
/// for both v1 and v2 in such a way that their representation will be different.
///
/// ## Error
/// - `ArgumentError`: throws `ArgumentError` when v1 == v2.
(String v1, String v2) formatBoth(int v1, int v2, Base b) {
  if (v1 == v2) {
    throw ArgumentError.value(
      v2,
      'input',
      "'input' must be different from 'max'",
    );
  }
  assert(v1 != v2);
  final int base = b.base;
  final List<String> units = b.units;
  final List<NumberFormat> formattingMask = <NumberFormat>[
    NumberFormat("#,##0.#"),
    NumberFormat("#,##0,000.#"),
    NumberFormat("#,##0,000,000.#"),
    NumberFormat("#,##0,000,000,000.#"),
    NumberFormat("#,##0,000,000,000,000.#"),
  ];

  // format max
  final int v1DigitGroups = (log(v1) / log(base)).floor();
  final double v1Size = v1 / pow(base, v1DigitGroups);

  // format input
  final int v2DigitGroups = (log(v2) / log(base)).floor();
  final double v2Size = v2 / pow(base, v2DigitGroups);
  String formattedV1;
  String formattedV2;
  for (final (int i, NumberFormat formatMask) in formattingMask.indexed) {
    formattedV1 =
        "${formatMask.format(v1Size * pow(base, i))} ${units[v1DigitGroups - i]}";
    formattedV2 =
        "${formatMask.format(v2Size * pow(base, i))} ${units[v2DigitGroups - i]}";
    if (formattedV1 != formattedV2) {
      return (formattedV1, formattedV2);
    }
  }
  throw StateError(
    "Unable to format 'max' and 'input' to distinct string representations despite having different values (max=$v1, input=$v2)",
  );
}

/// Helper function to format bytes into a human-readable string (e.g., KB, MB, GB).
///
/// ## Parameters:
/// - [bytes] The size in bytes to be formatted.
///
/// ## Returns:
/// A formatted string representing the size in human-readable units.
String formatBytes(int bytes, Base b) {
  double log10(num x) => log(x) / ln10;
  if (bytes <= 0) return '0 B';
  final int base = b.base;
  final List<String> units = b.units;
  final int digitGroups = (log10(bytes) / log10(base)).floor();
  final double size = bytes / pow(base, digitGroups);

  return "${NumberFormat("#,##0.#").format(size)} ${units[digitGroups]}";
}
