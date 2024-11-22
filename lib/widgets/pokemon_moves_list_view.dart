import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_flutter_app/providers/pokemon_data_providers.dart';
import 'package:pokemon_flutter_app/widgets/dual_text_row.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonMovesListView extends ConsumerWidget {
  final List moves;

  const PokemonMovesListView({Key? key, required this.moves}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: moves.length,
      itemBuilder: (context, index) {
        final move = moves[index];
        final moveDetailsAsyncValue =
            ref.watch(moveDetailsProvider(move.move!.url!));

        return moveDetailsAsyncValue.when(
          data: (moveDetails) {
            return _tile(context, false, move, moveDetails);
          },
          loading: () {
            return _tile(context, true, move, null);
          },
          error: (error, stack) {
            return Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        );
      },
    );
  }

  Widget _tile(
    BuildContext context,
    bool isLoading,
    dynamic move,
    dynamic moveDetails,
  ) {
    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03,
          vertical: MediaQuery.sizeOf(context).height * 0.01,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03,
          vertical: MediaQuery.sizeOf(context).height * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: isLoading
              ? [const Center(child: CircularProgressIndicator())]
              : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        move.move?.name?.toUpperCase() ?? 'Unknown',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "#${moveDetails?.id ?? "0"}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    moveDetails?.effect ?? 'No details available',
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DualTextRow(
                    title: 'TARGET',
                    subTitle: '${moveDetails?.target ?? 0}',
                    colour: Colors.orange,
                  ),
                  DualTextRow(
                    title: 'POWER',
                    subTitle: '${moveDetails?.power ?? 0}',
                    colour: Colors.red,
                  ),
                  DualTextRow(
                    title: 'ACCURACY',
                    subTitle: '${moveDetails?.accuracy ?? 0}',
                    colour: Colors.green,
                  ),
                  DualTextRow(
                    title: 'PP',
                    subTitle: '${moveDetails?.pp ?? 0}',
                    colour: Colors.blue,
                  ),
                ],
        ),
      ),
    );
  }
}
