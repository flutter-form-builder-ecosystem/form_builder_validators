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
