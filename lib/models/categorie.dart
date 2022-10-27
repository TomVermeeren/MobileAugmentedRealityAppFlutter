class Categorie {
  int id;
  String naam;
  String afbeeldingLink;

  Categorie(
      {required this.id, required this.naam, required this.afbeeldingLink});

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json['id'],
      naam: json['naam'],
      afbeeldingLink: json['afbeeldingLink'],
    );
  }

  Map<String, dynamic> toJson() => {
        'naam': naam,
        'afbeeldingLink': afbeeldingLink,
      };
}
