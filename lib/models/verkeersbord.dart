class Verkeersbord {
  int id;
  String naam;
  String beschrijving;
  String afbeeldingLink;
  String categorie;

  Verkeersbord({
    required this.id,
    required this.naam,
    required this.beschrijving,
    required this.afbeeldingLink,
    required this.categorie,
  });

  factory Verkeersbord.fromJson(Map<String, dynamic> json) {
    return Verkeersbord(
      id: json['id'],
      naam: json['naam'],
      beschrijving: json['beschrijving'],
      afbeeldingLink: json['afbeeldingLink'],
      categorie: json['categorie'],
    );
  }

  Map<String, dynamic> toJson() => {
        'naam': naam,
        'beschrijving': beschrijving,
        'afbeeldingLink': afbeeldingLink,
        'categorie': categorie,
      };
}
