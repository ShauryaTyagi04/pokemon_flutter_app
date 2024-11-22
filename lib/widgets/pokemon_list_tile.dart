import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/models/pokemon.dart';
import 'package:pokemon_flutter_app/pages/description_page.dart';
import 'package:pokemon_flutter_app/providers/pokemon_data_providers.dart';
import 'package:pokemon_flutter_app/widgets/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  const PokemonListTile({
    required this.pokemonURL,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritePokemonsProviderNotifier =
        ref.watch(favouritePokemonsProvider.notifier);
    final favouritePokemons = ref.watch(favouritePokemonsProvider);

    final pokemon = ref.watch(
      pokemonDataProvider(
        pokemonURL,
      ),
    );

    return pokemon.when(
      data: (data) {
        return _tile(
          context,
          false,
          data,
          favouritePokemonsProviderNotifier,
          favouritePokemons,
        );
      },
      error: (error, stackTrace) {
        return Text("Error: $error");
      },
      loading: () {
        return _tile(
          context,
          true,
          null,
          favouritePokemonsProviderNotifier,
          favouritePokemons,
        );
      },
    );
  }

  Widget _tile(
    BuildContext context,
    bool isLoading,
    Pokemon? pokemon,
    FavouritePokemonsProvider favouritePokemonsProviderNotifier,
    List<String> favouritePokemons,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onLongPress: () {
          if (!isLoading) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DescriptionPage(pokemonURL: pokemonURL),
              ),
            );
          }
        },
        onTap: () {
          if (!isLoading) {
            showDialog(
                context: context,
                builder: (_) {
                  return PokemonStatsCard(pokemonURL: pokemonURL);
                });
          }
        },
        child: ListTile(
          leading: pokemon == null
              ? const CircleAvatar()
              : CircleAvatar(
                  backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),
                ),
          title: Text(
            pokemon != null
                ? pokemon.name!.toUpperCase()
                : "Currently loading name for the pokemon",
          ),
          subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0} moves"),
          trailing: IconButton(
            onPressed: () {
              if (favouritePokemons.contains(pokemonURL)) {
                favouritePokemonsProviderNotifier
                    .removeFavouritePokemon(pokemonURL);
              } else {
                favouritePokemonsProviderNotifier
                    .addFavouritePokemon(pokemonURL);
              }
            },
            icon: Icon(
              favouritePokemons.contains(pokemonURL)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
