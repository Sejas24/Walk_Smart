class Blind {
  late String documentId;
  late String name;
  late String lastName;
  late String codeBlind;
  late String email;
  late String altitud;
  late String latitud;

  // Constructor
  Blind(
      { this.documentId = '',
      required this.name,
      required this.lastName,
      required this.email,
      required this.codeBlind,
      this.altitud = "-1",
      this.latitud = "-5"});

  // Default constructor
  Blind.defaultBlind() {
    documentId = '';
    name = '';
    lastName = '';
    email = '';
    codeBlind = '';
    altitud = "-1";
    latitud = "-5";
  }

  // Getters
  String get getDocumentId => documentId;
  String get getName => name;
  String get getLastName => lastName;
  String get getEmail => email;
  String get getCodeBlind => codeBlind;
  String get getAltitud => altitud;
  String get getLatitud => latitud;

  // Setters
  set setDocumentId(String value) => documentId = value;
  set setName(String value) => name = value;
  set setLastName(String value) => lastName = value;
  set setEmail(String value) => email = value;
  set setCodeBlind(String value) => codeBlind = value;
  set setAltitud(String value) => altitud = value;
  set setLatitud(String value) => latitud = value;
}
