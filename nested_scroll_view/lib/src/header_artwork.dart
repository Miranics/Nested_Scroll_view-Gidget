import 'package:flutter/material.dart';
// no shared constants required here

/// Header artwork used inside FlexibleSpaceBar. Light/dark variants supported.
class HeaderArtwork extends StatelessWidget {
  const HeaderArtwork({Key? key, this.light = false, this.headerImageUrl}) : super(key: key);

  final bool light;
  final String? headerImageUrl;

  /// Convenience constructor for the light variant used by the demo.
  factory HeaderArtwork.light({Key? key, String? headerImageUrl}) => HeaderArtwork(key: key, light: true, headerImageUrl: headerImageUrl);

  @override
  Widget build(BuildContext context) {
    final bgColors = light
        ? const [Color(0xFFFDF9F5), Color(0xFFF3EEE8), Color(0xFFEDE7E0)]
        : const [Color(0xFF0F3460), Color(0xFF6D0EB5), Color(0xFF35D0BA)];

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: bgColors, begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),

        // Optional colourful header image overlay (fades in)
        if (headerImageUrl != null)
          Positioned.fill(
            child: Opacity(
              opacity: 0.14,
              child: Image.network(headerImageUrl!, fit: BoxFit.cover, alignment: Alignment.center),
            ),
          ),

        // Tilted decorative panels
        Positioned(
          left: -40,
          top: 40,
          child: Transform.rotate(
            angle: -0.25,
            child: Container(width: 240, height: 160, decoration: BoxDecoration(color: light ? Colors.black12 : Colors.white10, borderRadius: BorderRadius.circular(24))),
          ),
        ),
        Positioned(
          right: -60,
          bottom: -10,
          child: Transform.rotate(
            angle: 0.20,
            child: Container(width: 300, height: 180, decoration: BoxDecoration(color: light ? Colors.black12 : Colors.black12, borderRadius: BorderRadius.circular(36))),
          ),
        ),

        // Center title and subtitle
        Positioned(
          left: 18,
          right: 18,
          bottom: 56,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Gallery — Curated Works', style: TextStyle(color: light ? Colors.black87 : Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('A minimal NestedScrollView demo styled as an art gallery', style: TextStyle(color: light ? Colors.black54 : Colors.white70)),
          ]),
        ),

        // Decorative floating avatar — tries to load local asset profile image and falls back to an icon
        Positioned(
          right: 18,
          top: 42,
          child: CircleAvatar(
            radius: 36,
            backgroundColor: light ? Colors.black12 : Colors.white,
            child: ClipOval(
              child: SizedBox(
                width: 64,
                height: 64,
                child: Image.asset('assets/profile.jpg', fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.person, size: 36)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
