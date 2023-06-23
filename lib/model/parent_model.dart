class Parent {
  String name = '';
  String lastName = '';
  String codeBlind = '';
  int cellphone = 0;

  // Constructor
  Parent(
      {required this.name,
      required this.lastName,
      required this.codeBlind,
      required this.cellphone});

  // Default constructor
  Parent.defaultParent() {
    name = '';
    lastName = '';
    codeBlind = '';
    cellphone = 0;
  }

  // Getters
  String get getName => name;
  String get getLastName => lastName;
  String get getCodeBlind => codeBlind;
  int get getCellphone => cellphone;

  // Setters
  set setName(String value) => name = value;
  set setLastName(String value) => lastName = value;
  set setCodeBlind(String value) => codeBlind = value;
  set setCellphone(int value) => cellphone = value;
}
