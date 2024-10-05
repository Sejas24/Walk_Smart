import 'package:baston_inteligente_mejorada/services/services.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/blocs.dart';
import '../views/views.dart';
import 'screens.dart';

const _kPages = <String, IconData>{'Perfil': Icons.person, 'Mapa': Icons.map};

class HomeBlind extends StatefulWidget {
  final SharedProvider sharedProvider;
  final BlindProvider blindProvider;

  const HomeBlind({
    Key? key,
    required this.blindProvider,
    required this.sharedProvider,
  }) : super(key: key);

  @override
  State<HomeBlind> createState() => _HomeBlindState();
}

class _HomeBlindState extends State<HomeBlind> {
  late BlindProvider blindProvider;
  late SharedProvider sharedProvider;

  @override
  void initState() {
    super.initState();
    blindProvider = widget.blindProvider;
    sharedProvider = widget.sharedProvider;
  }

  @override
  Widget build(BuildContext context) {
    // Aquí se proporciona LocationBloc en el árbol de widgets
    return BlocProvider(
      create: (context) => LocationBloc(), // Proveer LocationBloc
      child: DefaultTabController(
        length: 2, // El número de pestañas (Perfil y Mapa)
        initialIndex: 1,
        child: Scaffold(
          body: FutureBuilder(
            future: blindProvider.getBlindByEmail(sharedProvider.email),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final pagesOptions = [
                PerfilBlindScreen(
                  blindProvider: blindProvider,
                  sharedProvider: sharedProvider,
                ),
                BlocProvider(
                  create: (context) => MapBloc(
                      locationBloc: BlocProvider.of<LocationBloc>(context)),
                  child: MapView(
                    blindProvider: blindProvider,
                    locationBloc: BlocProvider.of<LocationBloc>(
                        context), // Pasar LocationBloc
                  ),
                ),
              ];

              return Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: pagesOptions
                          .map((page) => Center(child: page))
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: const Color.fromRGBO(63, 63, 156, 1),
            items: <TabItem>[
              for (final entry in _kPages.entries)
                TabItem(icon: entry.value, title: entry.key),
            ],
            onTap: (int index) {
              setState(() {
                // Actualizar la página seleccionada
              });
            },
          ),
        ),
      ),
    );
  }
}
