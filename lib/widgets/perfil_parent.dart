import 'package:baston_inteligente_mejorada/model/parent_model.dart';
import 'package:baston_inteligente_mejorada/widgets/perfil_background.dart';
import 'package:flutter/material.dart';

import '../providers/parent_provider.dart';
import '../providers/shared_provider.dart';

class PerfilParentScreen extends StatefulWidget {
  final ParentProvider parentProvider;
  final SharedProvider sharedProvider;

  const PerfilParentScreen(
      {super.key, required this.parentProvider, required this.sharedProvider});

  @override
  State<PerfilParentScreen> createState() => _PerfilParentScreenState();
}

class _PerfilParentScreenState extends State<PerfilParentScreen> {
  Parent? parent;

  @override
  void initState() {
    super.initState();
    loadParentData();
  }

  void loadParentData() {
    widget.parentProvider
        .getParentByEmail(widget.sharedProvider.email)
        .then((Parent loadedParent) {
      setState(() {
        parent = loadedParent;
      });
    }).catchError((error) {
      print('Error al cargar el usuario: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final String name = parent?.name ?? '';
    final String lastName = parent?.lastName ?? '';
    final String cellPhone = parent?.cellPhone ?? '';
    final String documentID = parent?.documentId ?? '';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(63, 63, 156, 1),
          title: const Text('Perfil'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              await widget.parentProvider.logout(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: PerfilBackground(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.04,
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/user.png',
                        height: 250,
                        width: 250,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '$name $lastName',
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    parent?.email ?? '',
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text(
                        'Editar Perfil',
                        style:
                            TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 50),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    onChanged: (value) {
                      parent?.name = value;
                    },
                    controller: TextEditingController(
                        text: parent?.name = parent?.name ?? ''),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Apellido'),
                    onChanged: (value) {
                      parent?.lastName = value;
                    },
                    controller: TextEditingController(
                        text: parent?.lastName = parent?.lastName ?? ''),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    enabled: false,
                    controller:
                        TextEditingController(text: parent?.email ?? ''),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Cellphone'),
                    onChanged: (value) {
                      parent?.cellPhone = value;
                    },
                    controller: TextEditingController(text: cellPhone),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.deepPurple,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.04,
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: const Text(
                            'Guardar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          await widget.parentProvider
                              .saveParentProfileData(parent!, documentID);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.deepPurple,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * 0.04,
                            horizontal: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: const Text(
                            'Borrar Cuenta',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                        'Esta Seguro de eliminar la cuenta?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            return Navigator.pop(
                                                context, false);
                                          },
                                          child: const Text(
                                            'Cancelar',
                                            style: TextStyle(color: Colors.red),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            await widget.parentProvider
                                                .deleteParentAccount(
                                                    context, documentID);
                                          },
                                          child: const Text('Si, Estoy Seguro'))
                                    ],
                                  ));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
