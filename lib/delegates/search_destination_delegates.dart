import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:baston_inteligente_mejorada/blocs/blocs.dart';
import 'package:baston_inteligente_mejorada/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final proximity =
        BlocProvider.of<LocationBloc>(context).state.lastKnowLocation;
    searchBloc.getPlacesByQuery(proximity!, query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
          itemCount: places.length,
          itemBuilder: (context, i) {
            final place = places[i].properties;
            return ListTile(
              title: Text(place.name),
              subtitle: Text(place.fullAddress),
              leading: const Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              onTap: () {
                final result = SearchResult(
                  cancel: false,
                  manual: false,
                  position: LatLng(
                    place.coordinates.latitude,
                    place.coordinates.longitude,
                  ),
                  name: place.name,
                  description: place.fullAddress,
                );
                searchBloc.add(AddToHistoryEvent(places[i]));
                close(context, result);
              },
            );
          },
          separatorBuilder: (context, i) => const Divider(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final history = BlocProvider.of<SearchBloc>(context).state.history;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: const Text(
            'Colocar la ubicacion manualmente',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        ),
        ...history.map(
          (place) => ListTile(
            title: Text(place.properties.name),
            subtitle: Text(place.properties.fullAddress),
            leading: const Icon(
              Icons.history,
              color: Colors.black,
            ),
            onTap: () {
              final result = SearchResult(
                cancel: false,
                manual: false,
                position: LatLng(
                  place.properties.coordinates.latitude,
                  place.properties.coordinates.longitude,
                ),
                name: place.properties.name,
                description: place.properties.fullAddress,
              );
              close(context, result);
            },
          ),
        ),
      ],
    );
  }
}
