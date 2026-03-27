import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/image_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Favourites', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.favourites.isEmpty) {
            return const Center(
              child: Text('No favourites saved yet. Start exploring!'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: provider.favourites.length,
            itemBuilder: (context, index) {
              final image = provider.favourites[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ImageCard(image: image),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
