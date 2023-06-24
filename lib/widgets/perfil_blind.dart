import 'package:baston_inteligente_mejorada/providers/providers.dart';
import 'package:flutter/material.dart';

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
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
              child: Text(
            "Perfil Page",
            style: TextStyle(fontSize: 20),
          ))
        ],
      ),
    );
  }
}
