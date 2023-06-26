import 'package:baston_inteligente_mejorada/providers/parent_provider.dart';
import 'package:flutter/material.dart';

class MapParentScreen extends StatefulWidget {
  final ParentProvider parentProvider;
  const MapParentScreen({super.key, required this.parentProvider});

  @override
  _MapParentScreen createState() => _MapParentScreen();
}

class _MapParentScreen extends State<MapParentScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Mapa'),
      centerTitle: true,
    ));
  }
}
