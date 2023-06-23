import 'package:flutter/material.dart';

class PerfilBlindScreen extends StatelessWidget {
  const PerfilBlindScreen({super.key});

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
