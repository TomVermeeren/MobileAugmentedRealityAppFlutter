class Verkeersbord {
  int id;
  String naam;
  String beschrijving;
  String afbeeldingLink;
  String categorie;
  String gehaald;

  Verkeersbord({
    required this.id,
    required this.naam,
    required this.beschrijving,
    required this.afbeeldingLink,
    required this.categorie,
    required this.gehaald,
  });

  factory Verkeersbord.fromJson(Map<String, dynamic> json) {
    return Verkeersbord(
      id: json['id'],
      naam: json['naam'],
      beschrijving: json['beschrijving'],
      afbeeldingLink: json['afbeeldingLink'],
      categorie: json['categorie'],
      gehaald: json['gehaald'],
    );
  }

  Map<String, dynamic> toJson() => {
        'naam': naam,
        'beschrijving': beschrijving,
        'afbeeldingLink': afbeeldingLink,
        'categorie': categorie,
        'gehaald': gehaald,
      };
}
