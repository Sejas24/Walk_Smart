import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

const _kPages = <String, IconData>{'Perfil': Icons.person, 'mapa': Icons.map};

class HomeParent extends StatefulWidget {
  const HomeParent({Key? key}) : super(key: key);

  @override
  _ConvexAppExampleState createState() => _ConvexAppExampleState();
}

class _ConvexAppExampleState extends State<HomeParent> {
  final _pageOption = [const PerfilBlindScreen(), const MapScreen()];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pageOption.length,
      initialIndex: 1,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  for (final icon in _pageOption)
                    Center(
                      child: icon,
                    ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar.badge(
          const <int, dynamic>{3: '99+'},
          backgroundColor: const Color.fromRGBO(63, 63, 156, 1),
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(icon: entry.value, title: entry.key),
          ],
          onTap: (int i) {
            setState(() {
              _pageOption[i];
            });
          },
        ),
      ),
    );
  }
}
