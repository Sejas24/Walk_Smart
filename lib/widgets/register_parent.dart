import 'package:baston_inteligente_mejorada/utils/decoration.dart';
import 'package:baston_inteligente_mejorada/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/parent_model.dart';
import '../providers/parent_provider.dart';

class RegisterParent extends StatelessWidget {
  const RegisterParent({super.key});

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
                ChangeNotifierProvider(
                    create: (_) => ParentProvider(), child: _LoginForm())
              ],
            )),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.indigo.withOpacity(0.6)),
                shape: MaterialStateProperty.all(const StadiumBorder()),
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
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<ParentProvider>(context);

    return Form(
      key: registerProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Pedro',
                labelText: 'Nombre',
                prefixIcon: Icons.person),
            onChanged: (value) => registerProvider.currentParent.name = value,
          ),
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'Rodriguez',
                labelText: 'Apellido',
                prefixIcon: Icons.person),
            onChanged: (value) =>
                registerProvider.currentParent.lastName = value,
          ),
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
                hintText: '77914419',
                labelText: 'Celular',
                prefixIcon: Icons.add_ic_call_outlined),
            onChanged: (value) => registerProvider.currentParent.cellphone,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'sergiocordova@gmail.com',
              labelText: 'Correo  Electrónico',
              prefixIcon: Icons.email,
            ),
            onChanged: (value) => registerProvider.email = value,
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
            onChanged: (value) => registerProvider.password = value,
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
                  : value != registerProvider.password
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
              _IngresarButton(registerProvider: registerProvider),
            ],
          ),
        ],
      ),
    );
  }
}

class _IngresarButton extends StatelessWidget {
  final ParentProvider registerProvider;

  const _IngresarButton({
    Key? key,
    required this.registerProvider,
  }) : super(key: key);

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
          registerProvider.isLoading ? 'Espere' : 'Siguiente',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPressed: () async {
        FocusScope.of(context).unfocus();
        if (!registerProvider.isValidForm()) return;

        registerProvider.isLoading = true;

        Future.delayed(const Duration(seconds: 2));

        //TODO: validar el login con backend
        registerProvider.isLoading = false;
        try {
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: registerProvider.email,
                  password: registerProvider.password);

          if (credential.user != null && context.mounted) {
            Parent parent = Parent(
                name: registerProvider.currentParent.name,
                lastName: registerProvider.currentParent.lastName,
                email: registerProvider.email,
                codeBlind: registerProvider
                    .currentParent.codeBlind, //TODO MODIFICAR LUEGO
                cellphone: registerProvider.currentParent.cellphone);

            print(parent.toString());
            print('!' +
                parent.name +
                '!' +
                parent.lastName +
                '!' +
                parent.email +
                '!' +
                parent.codeBlind +
                '!' +
                parent.cellphone.toString());

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => CodeBlindScreen(
            //           code: credential.user?.uid,
            //           registerProvider: registerProvider),
            //     ));
            Navigator.pushReplacementNamed(context, 'code_register_parent');
            registerProvider.postNewParentUser(parent);
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
