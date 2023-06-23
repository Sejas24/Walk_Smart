class Blind {
  String name = '';
  String codeBlind = '';
  String altitud = "-1";
  String latitud = "-5";
  List<String> parentListAcepted = [];
  List<String> parentListRequested = [];

  // Constructor
  Blind({
    required this.name,
    required this.codeBlind,
    this.altitud = "-1",
    this.latitud = "-5",
    required this.parentListAcepted,
    required this.parentListRequested,
  });

  // Default constructor
  Blind.defaultBlind() {
    name = '';
    codeBlind = '';
    altitud = "-1";
    latitud = "-5";
    parentListAcepted = [];
    parentListRequested = [];
  }

  // Getters
  String get getName => name;
  String get getCodeBlind => codeBlind;
  String get getAltitud => altitud;
  String get getLatitud => latitud;
  List<String> get getParentListAcepted => parentListAcepted;
  List<String> get getParentListRequested => parentListRequested;

  // Setters
  set setName(String value) => name = value;
  set setCodeBlind(String value) => codeBlind = value;
  set setAltitud(String value) => altitud = value;
  set setLatitud(String value) => latitud = value;
  set setParentListAcepted(List<String> value) => parentListAcepted = value;
  set setParentListRequested(List<String> value) => parentListRequested = value;
}
