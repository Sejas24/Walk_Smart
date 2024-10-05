import 'package:baston_inteligente_mejorada/services/services.dart';
import 'package:baston_inteligente_mejorada/utils/decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/parent_model.dart';
import '../services/parent_provider.dart';
import 'background_screens.dart';
import 'card_container.dart';
import 'code_register_parent.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class RegisterParent extends StatelessWidget {
  final SharedProvider sharedProvider;
  final ParentProvider parentProvider;

  const RegisterParent(
      {super.key, required this.sharedProvider, required this.parentProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundScreen(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Nueva Cuenta de Familiar',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 30),
                ChangeNotifierProvider.value(
                    value: sharedProvider,
                    child: _LoginForm(
                        sharedProvider: sharedProvider,
                        parentProvider: parentProvider))
              ],
            )),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                overlayColor:
                    WidgetStateProperty.all(Colors.indigo.withOpacity(0.6)),
                shape: WidgetStateProperty.all(const StadiumBorder()),
              ),
              child: const Text('¿Ya tienes una cuenta?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  final ParentProvider parentProvider;
  final SharedProvider sharedProvider;

  const _LoginForm(
      {required this.parentProvider, required this.sharedProvider});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Pedro',
                labelText: 'Nombre',
                prefixIcon: Icons.person),
            onChanged: (value) => parentProvider.currentParent.name = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Rodriguez',
                labelText: 'Apellido',
                prefixIcon: Icons.person),
            onChanged: (value) => parentProvider.currentParent.lastName = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
            keyboardType: TextInputType.phone,
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
                hintText: '77914419',
                labelText: 'Phone number',
                prefixIcon: Icons.add_ic_call_outlined),
            onChanged: (value) =>
                parentProvider.currentParent.cellPhone = value,
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'sergiocordova@gmail.com',
              labelText: 'Correo  Electrónico',
              prefixIcon: Icons.email,
            ),
            onChanged: (value) => {
              sharedProvider.email = value,
              parentProvider.currentParent.email = value
            },
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El correo electrónico no es válido';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '********',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock,
            ),
            onChanged: (value) => sharedProvider.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe tener al menos 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '********',
              labelText: 'Confirmar Contraseña',
              prefixIcon: Icons.lock,
            ),
            validator: (value) {
              return (value == null || value.length < 6)
                  ? 'La contraseña debe tener al menos 6 caracteres'
                  : value != sharedProvider.password
                      ? 'Las contraseñas no coinciden'
                      : null;
            },
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                  child: const Text(
                    'Volver',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
              ),
              const SizedBox(width: 30),
              _IngresarButton(
                  sharedProvider: sharedProvider,
                  parentProvider: parentProvider),
            ],
          ),
        ],
      ),
    );
  }
}

class _IngresarButton extends StatelessWidget {
  final SharedProvider sharedProvider;
  final ParentProvider parentProvider;

  const _IngresarButton(
      {Key? key, required this.sharedProvider, required this.parentProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Colors.deepPurple,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
        child: Text(
          sharedProvider.isLoading ? 'Espere' : 'Siguiente',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () async {
        FocusScope.of(context).unfocus();
        if (!sharedProvider.isValidForm(formKey)) return;

        sharedProvider.isLoading = true;

        Future.delayed(const Duration(seconds: 2));

        //TODO: validar el login con backend
        sharedProvider.isLoading = false;
        try {
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: sharedProvider.email,
                  password: sharedProvider.password);

          if (credential.user != null && context.mounted) {
            Parent parent = Parent(
                name: parentProvider.currentParent.name,
                lastName: parentProvider.currentParent.lastName,
                email: sharedProvider.email,
                codeBlind: parentProvider
                    .currentParent.codeBlind, //TODO MODIFICAR LUEGO
                cellPhone: parentProvider.currentParent.cellPhone);

            parentProvider
                .postNewParentUser(parent)
                .then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CodeRegisterParentScreen(
                              sharedProvider: sharedProvider,
                              parentProvider: parentProvider)),
                    ));
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
