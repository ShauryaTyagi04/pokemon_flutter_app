import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/widgets/dual_text_row.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonDescriptionDetails extends StatelessWidget {
  final dynamic pokemon;
  final AsyncValue<dynamic> detailedSpeciesAsyncValue;

  const PokemonDescriptionDetails({
    required this.pokemon,
    required this.detailedSpeciesAsyncValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: detailedSpeciesAsyncValue.when(
        data: (detailedSpecies) {
          return _description(context, false, pokemon, detailedSpecies);
        },
        loading: () {
          return _description(context, true, null, null);
        },
        error: (error, stack) {
          return Center(
            child: Text(
              'Error loading description: $error',
              style: const TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }

  Widget _description(
    BuildContext context,
    bool isLoading,
    dynamic pokemon,
    dynamic detailedSpecies,
  ) {
    if (isLoading) {
      return Skeletonizer(
        enabled: true,
        ignoreContainers: true,
        child: Column(
          children: List.generate(
            6,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
      );
    }

    String description =
        (detailedSpecies?.description ?? 'No description available')
            .replaceAll(RegExp(r'[\n\f\r]+'), ' ');
    String generation =
        (detailedSpecies?.generation ?? "N/A").replaceAll("generation-", "");
    String eggGroups = (detailedSpecies?.eggGroups ?? []).join(", ");

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DualTextRow(
                  title: "HEIGHT",
                  subTitle: "${pokemon.height! * 10}cm",
                ),
                DualTextRow(
                  title: "WEIGHT",
                  subTitle: "${pokemon.weight! / 10}kg",
                ),
                DualTextRow(
                  title: "HABITAT",
                  subTitle: "${detailedSpecies?.habitat ?? 'N/A'}",
                ),
                DualTextRow(
                  title: "COLOUR",
                  subTitle: "${detailedSpecies?.colour ?? 'N/A'}",
                ),
                DualTextRow(
                  title: "SHAPE",
                  subTitle: "${detailedSpecies?.shape ?? 'N/A'}",
                ),
                DualTextRow(
                  title: "EGG GROUPS",
                  subTitle: eggGroups,
                ),
                DualTextRow(
                  title: 'GROWTH RATE',
                  subTitle: detailedSpecies?.growthRate?.toString() ?? "0",
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (pokemon.stats ?? [])
                      .map<Widget>((s) => DualTextRow(
                            title: "${s.stat?.name?.toUpperCase()}",
                            subTitle: s.baseStat.toString(),
                          ))
                      .toList(),
                ),
                DualTextRow(
                  title: "GENERATION",
                  subTitle: generation,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
