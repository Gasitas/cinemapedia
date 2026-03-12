class Cast {
  final int gender;
  final int id;
  final String name;
  final String? profilePath;
  final int? castId;
  final String? character;


  Cast({
    required this.gender,
    required this.id,
    required this.name,
    required this.profilePath,
    this.castId,
    this.character
  });
    
}