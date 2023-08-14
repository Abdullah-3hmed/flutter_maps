String getCountryFlag() {
  String countryCode = "eg";
  return countryCode.toUpperCase().replaceAllMapped(RegExp(r"[A-Z]"), (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
}
