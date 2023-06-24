import 'package:baston_inteligente_mejorada/providers/providers.dart';
import 'package:flutter/material.dart';

import '../providers/parent_provider.dart';

class PerfilParentScreen extends StatelessWidget {
  final ParentProvider parentProvider;
  const PerfilParentScreen({super.key, required this.parentProvider});

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
