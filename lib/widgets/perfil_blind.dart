import 'package:baston_inteligente_mejorada/widgets/perfil_background.dart';
import 'package:flutter/material.dart';

import 'package:baston_inteligente_mejorada/providers/providers.dart';

class PerfilBlindScreen extends StatelessWidget {
  final BlindProvider blindProvider;
  const PerfilBlindScreen({super.key, required this.blindProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(63, 63, 156, 1),
          title: const Text('Perfil'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
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
                    'nombre y apellido',
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email del perfil',
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
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
                    decoration: InputDecoration(labelText: 'Nombre'),
                    // onChanged: (value) => setState(() => name = value),
                    //controller: TextEditingController(text: name),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: 'Apellido'),
                    // onChanged: (value) => setState(() => lastName = value),
                    // controller: TextEditingController(text: lastName),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'Código de identificación'),
                    enabled: false,
                    //controller: TextEditingController(text: codeBlind),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                    enabled: false,
                    //controller: TextEditingController(text: email),
                  ),
                  SizedBox(height: 50),
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
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
                        onPressed: () {},
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
