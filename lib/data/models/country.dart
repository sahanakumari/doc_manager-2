

class Country {
  final String name;
  final String? alpha2Code;
  final String extension;

  Country({required this.name, this.alpha2Code, required this.extension});

  @override
  String toString() => "$name ($extension)";

  @override
  bool operator ==(dynamic other) => extension == other.extension;

  @override
  int get hashCode => super.hashCode;

  static Country india = Country(name: "India", extension: "+91");
  static Country nepal = Country(name: "Nepal", extension: "+977");
}


