int getRealIndex(int position, int base, int? length) {
  final int offset = position - base;
  return remainder(offset, length);
}

/// Returns the remainder of the modulo operation [input] % [source], and adjust it for
/// negative values.
int remainder(int input, int? source) {
  if (source == 0) return 0;
  final int result = input % source!;
  return result < 0 ? source + result : result;
}