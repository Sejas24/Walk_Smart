import 'package:baston_inteligente_mejorada/providers/parent_provider.dart';
import 'package:baston_inteligente_mejorada/widgets/map_parent.dart';
import 'package:baston_inteligente_mejorada/widgets/perfil_parent.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../providers/shared_provider.dart';
import 'widgets.dart';

const _kPages = <String, IconData>{'Perfil': Icons.person, 'mapa': Icons.map};

class HomeParent extends StatefulWidget {
  final SharedProvider sharedProvider;
  final ParentProvider parentProvider;
  const HomeParent(
      {Key? key, required this.parentProvider, required this.sharedProvider})
      : super(key: key);

  @override
  State<HomeParent> createState() => _ConvexAppExampleState();
}

class _ConvexAppExampleState extends State<HomeParent> {
  late ParentProvider parentProvider;
  late SharedProvider sharedProvider;

  @override
  void initState() {
    super.initState();
    parentProvider = widget.parentProvider;
    sharedProvider = widget.sharedProvider;
  }

  @override
  Widget build(BuildContext context) {
    final pagesOptions = [
      PerfilParentScreen(parentProvider: parentProvider),
      MapParentScreen(parentProvider: parentProvider)
    ];

    return DefaultTabController(
      length: pagesOptions.length,
      initialIndex: 1,
      child: Scaffold(
        body: FutureBuilder(
          future: parentProvider.getBlindByEmail(parentProvider.blind.email),
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
