import 'package:flutter/material.dart';
// no shared constants required here

/// A single gallery card used in the grid. Supports network URLs and asset paths.
class GalleryCard extends StatelessWidget {
  const GalleryCard({required this.index, required this.imageSource, super.key});

  final int index;
  final String imageSource;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image (network placeholder or asset)
            _buildImage(imageSource),
            // Caption overlay
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                color: const Color.fromRGBO(255, 255, 255, 0.9),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  Text('Artwork #${index + 1}', style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('Artist name', style: TextStyle(color: Colors.black54, fontSize: 12)),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String src) {
    if (src.startsWith('http')) {
      return Image.network(src, fit: BoxFit.cover, loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(color: const Color(0xFFF2F0EC));
      }, errorBuilder: (context, err, st) {
        return Container(color: const Color(0xFFF2F0EC), child: const Icon(Icons.broken_image, size: 48, color: Colors.black26));
      });
    }

    return Image.asset(src, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: const Color(0xFFF2F0EC), child: const Icon(Icons.broken_image, size: 48, color: Colors.black26)));
  }
}
