import 'package:flutter/material.dart';
import 'package:v_lille/models/station.dart';
import 'package:v_lille/widgets/station_list.dart';

class StationSearchDelegate extends SearchDelegate {
  // Class managing the search bar

  final List<Station> stations;
  final Function(Station) onStationTapped;

  StationSearchDelegate({
    required this.onStationTapped,
    required this.stations,
  });

  List<Station> results = <Station>[];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(
            Icons.clear,
          ),
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => results.isEmpty
      ? const Center(child: Text('No results found'))
      : StationList(
          stations: results,
          onStationTapped: onStationTapped,
        );

  @override
  Widget buildSuggestions(BuildContext context) {
    results = stations
        .where((station) =>
            station.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return results.isEmpty
        ? const Center(child: Text('No results found'))
        : StationList(
            stations: results,
            onStationTapped: onStationTapped,
          );
  }
}
