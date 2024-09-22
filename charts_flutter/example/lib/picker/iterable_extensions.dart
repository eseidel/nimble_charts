extension IterableExtensions<T> on Iterable<T> {
  /// Non mutating sort
  List<T> orderBy([int Function(T a, T b)? compare]) => toList()..sort(compare);
}
