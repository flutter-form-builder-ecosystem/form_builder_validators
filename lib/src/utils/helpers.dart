// Helper functions for validator and sanitizer.

import 'dart:math';

import 'package:intl/intl.dart';

T shift<T>(List<T> l) {
  if (l.isNotEmpty) {
    final first = l.first;
    l.removeAt(0);
    return first;
  }
  return null as T;
}

Map merge(Map? obj, Map? defaults) {
  obj ??= <dynamic, dynamic>{};
  defaults
      ?.forEach((dynamic key, dynamic val) => obj!.putIfAbsent(key, () => val));
  return obj;
}

String fileExtensionFromPath(String path) {
  final List<String> parts = path.split('.');

  assert(
    parts.length > 1 && parts.last.isNotEmpty,
    'Invalid file path format: $path. Path should contain a valid extension.',
  );

  return parts.last;
}

/// Helper function to format bytes into a human-readable string (e.g., KB, MB, GB).
String formatBytes(int bytes, {bool base1024 = true}) {
  double log10(num x) => log(x) / ln10;

  if (bytes <= 0) return '0 B';

  final int base = base1024 ? 1024 : 1000;
  final List<String> units = base1024
      ? <String>['B', 'KiB', 'MiB', 'GiB', 'TiB']
      : <String>['B', 'kB', 'MB', 'GB', 'TB'];

  final int digitGroups = (log10(bytes) / log10(base)).floor();
  final double size = bytes / pow(base, digitGroups);

  return "${NumberFormat("#,##0.#").format(size)} ${units[digitGroups]}";
}
