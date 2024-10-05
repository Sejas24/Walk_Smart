import 'package:baston_inteligente_mejorada/models/blind_model.dart';
import 'package:baston_inteligente_mejorada/screens/perfil_background.dart';
import 'package:flutter/material.dart';

import 'package:baston_inteligente_mejorada/services/services.dart';

class PerfilBlindScreen extends StatefulWidget {
  final BlindProvider blindProvider;
  final SharedProvider sharedProvider;

  const PerfilBlindScreen(
      {super.key, required this.blindProvider, required this.sharedProvider});

  @override
  State<PerfilBlindScreen> createState() => _PerfilBlindScreenState();
}

class _PerfilBlindScreenState extends State<PerfilBlindScreen> {
  Blind? blind;

  @override
  void initState() {
    super.initState();
    loadBlindData();
  }

  void loadBlindData() {
    widget.blindProvider
        .getBlindByEmail(widget.sharedProvider.email)
        .then((Blind loadedBlind) {
      setState(() {
        blind = loadedBlind;
      });
    }).catchError((error) {
      print('Error al cargar el usuario: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final String name = blind?.name ?? '';
    final String lastName = blind?.lastName ?? '';
    final String documentID = blind?.documentId ?? '';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(63, 63, 156, 1),
          title: const Text('Perfil'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              await widget.blindProvider.logout(context);
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
                    blind?.email ?? '',
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
                  Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(labelText: 'Nombre'),
                        onChanged: (value) {
                          blind?.name = value;
                        },
                        controller: TextEditingController(
                            text: blind?.name = blind?.name ?? ''),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration:
                            const InputDecoration(labelText: 'Apellido'),
                        onChanged: (value) {
                          blind?.lastName = value;
                        },
                        controller: TextEditingController(
                            text: blind?.lastName = blind?.lastName ?? ''),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: 'Código de identificación'),
                        enabled: false,
                        controller:
                            TextEditingController(text: blind?.codeBlind ?? ''),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        enabled: false,
                        controller:
                            TextEditingController(text: blind?.email ?? ''),
                      ),
                      const SizedBox(height: 50),
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
                                vertical:
                                    MediaQuery.of(context).size.width * 0.04,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1,
                              ),
                              child: const Text(
                                'Guardar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              await widget.blindProvider
                                  .saveBlindProfileData(blind!, documentID);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
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
                                vertical:
                                    MediaQuery.of(context).size.width * 0.04,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1,
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
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                await widget.blindProvider
                                                    .deleteBlindAccount(
                                                        context, documentID);
                                              },
                                              child: const Text(
                                                  'Si, Estoy Seguro'))
                                        ],
                                      ));
                            },
                          ),
                        ],
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
