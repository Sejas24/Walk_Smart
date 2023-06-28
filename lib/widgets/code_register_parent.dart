import 'package:baston_inteligente_mejorada/providers/parent_provider.dart';
import 'package:baston_inteligente_mejorada/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/decoration.dart';
import 'card_container.dart';
import 'type_register_background.dart';

class CodeRegisterParentScreen extends StatelessWidget {
  final SharedProvider sharedProvider;
  final ParentProvider parentProvider;
  final GlobalKey<FormState> formKey;

  CodeRegisterParentScreen({
    Key? key,
    required this.parentProvider,
    required this.sharedProvider,
  })  : formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TypeRegisterBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Codigo del familiar No Vidente',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider.value(
                      value: parentProvider,
                      child: _LoginForm(
                        sharedProvider: sharedProvider,
                        parentProvider: parentProvider,
                        formKey: formKey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final SharedProvider sharedProvider;
  final ParentProvider parentProvider;
  final GlobalKey<FormState> formKey;

  const _LoginForm({
    required this.sharedProvider,
    required this.parentProvider,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double buttonWidth = constraints.maxWidth * 0.4;

        return SizedBox(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 30),
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'ASG350',
                    labelText: 'Codigo No Vidente',
                    prefixIcon: Icons.lock,
                  ),
                  onChanged: (value) =>
                      {parentProvider.currentParent.codeBlind = value},
                  validator: (value) {
                    return (value != null && value.length >= 6)
                        ? null
                        : 'El codigo debe tener 6 caracteres';
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.deepPurple,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'login',
                            (route) => false,
                          );
                        },
                        child: Container(
                          width: buttonWidth,
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: buttonWidth * 0.2,
                          ),
                          child: const Text(
                            'Volver',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _IngresarButton(
                        sharedProvider: sharedProvider,
                        width: buttonWidth,
                        parentProvider: parentProvider,
                        formKey: formKey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _IngresarButton extends StatelessWidget {
  final SharedProvider sharedProvider;
  final ParentProvider parentProvider;
  final double width;
  final GlobalKey<FormState> formKey;

  const _IngresarButton(
      {Key? key,
      required this.sharedProvider,
      required this.width,
      required this.parentProvider,
      required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Colors.deepPurple,
      onPressed: sharedProvider.isLoading
          ? null
          : () async {
              FocusScope.of(context).unfocus();
              if (!sharedProvider.isValidForm(formKey)) return;

              sharedProvider.isLoading = true;

              await Future.delayed(const Duration(seconds: 2));

              // TODO: validar el login con backend
              sharedProvider.isLoading = false;
              parentProvider
                  .updateParentCodeBlindByBlindCode(
                      parentProvider.currentParent.codeBlind)
                  .then((value) {
                Navigator.pushReplacementNamed(context, 'homeparent');
              });
            },
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: width * 0.2,
        ),
        child: const Text(
          'Ingresar',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
