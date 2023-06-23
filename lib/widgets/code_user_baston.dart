import 'package:flutter/material.dart';

import '../providers/blind_provider.dart';
import 'card_container.dart';
import 'type_register_background.dart';

class CodeBlindScreen extends StatelessWidget {
  final String? code;
  final BlindProvider blindProvider;

  const CodeBlindScreen({super.key, required this.code, required this.blindProvider});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TypeRegisterBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Codigo Usuario del Baston: ',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 30),
                Text(code.toString().substring(0, 7),
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 30),
                _IngresarButton(),
              ],
            )),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
  }
}

class _IngresarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Colors.deepPurple,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
        child: const Text(
          'Ingresar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'homeblind');
      },
    );
  }
}
