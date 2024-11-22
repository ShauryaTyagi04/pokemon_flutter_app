import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/providers/pokemon_data_providers.dart';
import 'package:pokemon_flutter_app/widgets/heading_container.dart';
import 'package:pokemon_flutter_app/widgets/pokemon_description_details.dart';
import 'package:pokemon_flutter_app/widgets/pokemon_moves_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DescriptionPage extends ConsumerStatefulWidget {
  final String pokemonURL;

  const DescriptionPage({required this.pokemonURL, Key? key}) : super(key: key);

  @override
  ConsumerState<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends ConsumerState<DescriptionPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final favouritePokemonsProviderNotifier =
        ref.watch(favouritePokemonsProvider.notifier);
    final favouritePokemons = ref.watch(favouritePokemonsProvider);
    final pokemonAsyncValue = ref.watch(pokemonDataProvider(widget.pokemonURL));

    return pokemonAsyncValue.when(
      data: (pokemon) => _descriptionScaffold(
        context,
        false,
        pokemon,
        favouritePokemons,
        favouritePokemonsProviderNotifier,
      ),
      loading: () => _descriptionScaffold(
        context,
        true,
        null,
        favouritePokemons,
        favouritePokemonsProviderNotifier,
      ),
      error: (error, _) => Scaffold(
        body: Center(
          child: Text('Error loading Pokémon: $error'),
        ),
      ),
    );
  }

  Widget _descriptionScaffold(
    BuildContext context,
    bool isLoading,
    dynamic pokemon,
    List<String> favouritePokemons,
    dynamic favouritePokemonsProviderNotifier,
  ) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: isLoading
            ? Skeletonizer(
                child: Container(
                  width: 150,
                  height: 20,
                  color: Colors.grey[300],
                ),
              )
            : Text(
                pokemon!.name!.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
        actions: isLoading
            ? []
            : [
                IconButton(
                  onPressed: () {
                    if (favouritePokemons.contains(widget.pokemonURL)) {
                      favouritePokemonsProviderNotifier
                          .removeFavouritePokemon(widget.pokemonURL);
                    } else {
                      favouritePokemonsProviderNotifier
                          .addFavouritePokemon(widget.pokemonURL);
                    }
                  },
                  icon: Icon(
                    favouritePokemons.contains(widget.pokemonURL)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              ],
      ),
      body: Skeletonizer(
        enabled: isLoading,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 85,
                      backgroundImage: isLoading
                          ? null
                          : NetworkImage(pokemon.sprites!.frontDefault!),
                      backgroundColor: isLoading ? Colors.grey[300] : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: isLoading
                          ? Skeletonizer(
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                color: Colors.grey[300],
                              ),
                            )
                          : PokemonDescriptionDetails(
                              pokemon: pokemon,
                              detailedSpeciesAsyncValue: ref.watch(
                                pokemonDetailsProvider(pokemon.species!.url!),
                              ),
                            ),
                    ),
                    isLoading
                        ? Skeletonizer(
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              color: Colors.grey[300],
                            ),
                          )
                        : HeadingContainer(
                            title: "${pokemon.moves?.length} Moves"),
                    isLoading
                        ? Column(
                            children: List.generate(
                              6,
                              (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  height: 20,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                          )
                        : PokemonMovesListView(moves: pokemon.moves!),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: _scrollToTop,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
