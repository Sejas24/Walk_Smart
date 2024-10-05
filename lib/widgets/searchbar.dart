import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baston_inteligente_mejorada/blocs/blocs.dart';
import 'package:baston_inteligente_mejorada/models/models.dart';
import 'package:baston_inteligente_mejorada/delegates/delegates.dart';

class SearchBarMap extends StatelessWidget {
  const SearchBarMap({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : ElasticInDown(
                child: const _SearchBarBody(),
              );
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody();

  void onSearchResults(BuildContext context, SearchResult result) async {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final start = locationBloc.state.lastKnowLocation;

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }
    if (start == null) return;

    if (result.position != null) {
      final destination =
          await searchBloc.getCoorsStartToEnd(start, result.position!);
      await mapBloc.drawRoutePolyline(destination);
    }
  }

  Future<void> myAsyncMethod(BuildContext context) async {
    final result = await showSearch(
        context: context, delegate: SearchDestinationDelegate());
    if (result == null) return;
    if (context.mounted) onSearchResults(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: GestureDetector(
          onTap: () => const _SearchBarBody().myAsyncMethod(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  )
                ]),
            child: const Text('¿Donde quieres ir?',
                style: TextStyle(color: Colors.black87)),
          ),
        ),
      ),
    );
  }
}
