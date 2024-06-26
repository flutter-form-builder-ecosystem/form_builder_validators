// Helper functions for validator and sanitizer.

T shift<T>(List<T> l) {
  if (l.isNotEmpty) {
    final T first = l.first;
    l.removeAt(0);
    return first;
  }
  return null as T;
}
