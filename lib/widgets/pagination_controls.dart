import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class PaginationControls extends StatelessWidget {
  const PaginationControls({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    if (provider.currentImages.isEmpty && !provider.isLoading) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: provider.currentPage > 1 && !provider.isLoading
                ? () => context.read<AppProvider>().previousPage()
                : null,
            child: const Text('Previous'),
          ),
          const SizedBox(width: 16),
          provider.isLoading 
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(
                  'Page ${provider.currentPage}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: provider.currentImages.isNotEmpty && !provider.isLoading
                ? () => context.read<AppProvider>().nextPage()
                : null,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
