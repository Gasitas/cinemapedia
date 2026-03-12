// To parse this JSON data, do
//
//     final actorDbResponse = actorDbResponseFromJson(jsonString);

import 'dart:convert';

ActorDbResponse actorDbResponseFromJson(String str) => ActorDbResponse.fromJson(json.decode(str));

String actorDbResponseToJson(ActorDbResponse data) => json.encode(data.toJson());

class ActorDbResponse {
    final int id;
    final List<CastMovie> cast;
    final List<CastMovie> crew;

    ActorDbResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory ActorDbResponse.fromJson(Map<String, dynamic> json) => ActorDbResponse(
        id: json["id"],
        cast: List<CastMovie>.from(json["cast"].map((x) => CastMovie.fromJson(x))),
        crew: List<CastMovie>.from(json["crew"].map((x) => CastMovie.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    };
}

class CastMovie {
    final bool adult;
    final int gender;
    final int id;
    final Department knownForDepartment;
    final String name;
    final String originalName;
    final double popularity;
    final String? profilePath;
    final int? castId;
    final String? character;
    final String creditId;
    final int? order;
    final Department? department;
    final String? job;

    CastMovie({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
        required this.profilePath,
        this.castId,
        this.character,
        required this.creditId,
        this.order,
        this.department,
        this.job,
    });

    factory CastMovie.fromJson(Map<String, dynamic> json) => CastMovie(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: departmentValues.map[json["known_for_department"]]!,
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: departmentValues.map[json["department"]]!,
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": departmentValues.reverse[department],
        "job": job,
    };
}

enum Department {
    acting,
    art,
    camera,
    costumeMakeUp,
    crew,
    directing,
    editing,
    lighting,
    production,
    sound,
    visualeffects,
    writting
}

final departmentValues = EnumValues({
    "Acting": Department.acting,
    "Art": Department.art,
    "Camera": Department.camera,
    "Costume & Make-Up": Department.costumeMakeUp,
    "Crew": Department.crew,
    "Directing": Department.directing,
    "Editing": Department.editing,
    "Lighting": Department.lighting,
    "Production": Department.production,
    "Sound": Department.sound,
    "Visual Effects": Department.visualeffects,
    "Writing": Department.writting
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
