class Parent {
  String documentId = '';
  String name = '';
  String lastName = '';
  String email = '';
  String codeBlind = '';
  String cellPhone = '';

  // Constructor
  Parent(
      {this.documentId = '',
      required this.name,
      required this.lastName,
      required this.email,
      required this.codeBlind,
      required this.cellPhone});

  // Default constructor
  Parent.defaultParent() {
    documentId = '';
    name = '';
    lastName = '';
    email = '';
    codeBlind = '';
    cellPhone = '';
  }

  // Getters
  String get getDocumentId => documentId;
  String get getName => name;
  String get getLastName => lastName;
  String get getEmail => email;
  String get getCodeBlind => codeBlind;
  String get getCellphone => cellPhone;

  // Setters
  set setDocumentId(String value) => documentId = value;
  set setName(String value) => name = value;
  set setLastName(String value) => lastName = value;
  set setEmail(String value) => email = value;
  set setCodeBlind(String value) => codeBlind = value;
  set setCellphone(String value) => cellPhone = value;
}
