class Actor {
  final int id;
  final String name;
  final String placeOfBirth;
  final String? profilePath;
  final String? biography;

  Actor({
    required this.id,
    required this.name,
    required this.placeOfBirth,
    this.profilePath,
    this.biography,
  });
}