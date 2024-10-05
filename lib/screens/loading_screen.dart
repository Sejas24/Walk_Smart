import 'package:baston_inteligente_mejorada/services/blind_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import 'gps_access_screen.dart';
import 'map_screen.dart';

class LoadingScreen extends StatelessWidget {
  final BlindProvider blindProvider;
  const LoadingScreen({super.key, required this.blindProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        return state.isAllGranted ? const MapScreen() : const GpsAccessScreen();
      },
    ));
  }
}
