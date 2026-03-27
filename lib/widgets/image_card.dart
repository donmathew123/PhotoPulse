import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/image_model.dart';
import '../providers/app_provider.dart';
import '../screens/image_detail_screen.dart';

class ImageCard extends StatelessWidget {
  final ImageModel image;

  const ImageCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailScreen(image: image),
          ),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'image_${image.id}',
            child: CachedNetworkImage(
              imageUrl: image.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Consumer<AppProvider>(
              builder: (context, provider, child) {
                final isFav = provider.isFavourite(image.id);
                return GestureDetector(
                  onTap: () {
                    provider.toggleFavourite(image);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.white,
                      size: 24,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
