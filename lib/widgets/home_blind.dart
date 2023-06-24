import 'package:baston_inteligente_mejorada/model/blind_model.dart';
import 'package:baston_inteligente_mejorada/providers/blind_provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

const _kPages = <String, IconData>{'Perfil': Icons.person, 'Mapa': Icons.map};

class HomeBlind extends StatefulWidget {
  final BlindProvider blindProvider;
  const HomeBlind({Key? key, required this.blindProvider}) : super(key: key);

  @override
  State<HomeBlind> createState() => _HomeBlindState();
}

class _HomeBlindState extends State<HomeBlind> {
  late BlindProvider blindProvider;

  @override
  void initState() {
    super.initState();
    blindProvider = widget.blindProvider;
  }

  @override
  Widget build(BuildContext context) {
    final pagesOptions = [
      PerfilBlindScreen(
        blindProvider: blindProvider,
      ),
      MapScreen(
        blindProvider: blindProvider,
      )
    ];

    print(blindProvider.email);

    return DefaultTabController(
      length: pagesOptions.length,
      initialIndex: 1,
      child: Scaffold(
        body: FutureBuilder(
          future: blindProvider.getBlindByEmail(blindProvider.email),
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      for (final page in pagesOptions)
                        Center(
                          child: page,
                        ),
                    ],
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
              pagesOptions[index];
            });
          },
        ),
      ),
    );
  }
}
