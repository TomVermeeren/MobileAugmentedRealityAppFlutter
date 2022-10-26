class Verkeersbord {
  int id;
  String naam;
  String beschrijving;
  String afbeeldingLink;

  Verkeersbord(
      {required this.id,
      required this.naam,
      required this.beschrijving,
      required this.afbeeldingLink});

  factory Verkeersbord.fromJson(Map<String, dynamic> json) {
    return Verkeersbord(
      id: json['id'],
      naam: json['naam'],
      beschrijving: json['beschrijving'],
      afbeeldingLink: json['afbeeldingLink'],
    );
  }

  Map<String, dynamic> toJson() => {
        'naam': naam,
        'beschrijving': beschrijving,
        'afbeeldingLink': afbeeldingLink,
      };
}
