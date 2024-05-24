// Helper functions for validator and sanitizer.

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
  final splitter = path.split('.');
  return splitter.length > 1 ? splitter.last : "";
}

/// Helper function to format bytes into a human-readable string (e.g., KB, MB, GB).
String formatBytes(int bytes) {
  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
  var i = 0;
  double size = bytes.toDouble();
  while (size > 1024 && i < suffixes.length - 1) {
    size /= 1024;
    i++;
  }
  // Truncate to 1 decimal place
  return '${size.toStringAsFixed(1)}${suffixes[i]}';
}