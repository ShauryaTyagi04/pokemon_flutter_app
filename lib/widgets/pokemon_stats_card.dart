import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/providers/pokemon_data_providers.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonURL;

  PokemonStatsCard({
    super.key,
    required this.pokemonURL,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(
      pokemonDataProvider(
        pokemonURL,
      ),
    );

    return AlertDialog(
      title: const Text('Statistics'),
      content: pokemon.when(
        data: (data) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data?.stats?.map(
                  (s) {
                    return Row(children: [
                      Text(
                        "${s.stat?.name?.toUpperCase()}: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        s.baseStat.toString(),
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ]);
                  },
                ).toList() ??
                [],
          );
        },
        error: (error, stackTrace) {
          return Text(
            error.toString(),
          );
        },
        loading: () {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        },
      ),
    );
  }
}
