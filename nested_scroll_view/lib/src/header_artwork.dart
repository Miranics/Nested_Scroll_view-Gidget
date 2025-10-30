import 'package:flutter/material.dart';


/// Header artwork used inside FlexibleSpaceBar. Light/dark variants supported.
class HeaderArtwork extends StatelessWidget {
  const HeaderArtwork({super.key, this.light = false, this.headerImageUrl});

  final bool light;
  final String? headerImageUrl;


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

        // Optional colourful header image overlay (fades in). Increased opacity
      
        if (headerImageUrl != null)
          Positioned.fill(
            child: Opacity(
              opacity: 0.20,
              child: Image.network(
                headerImageUrl!,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  // while loading show a subtle tint that keeps header readable
                  return ColoredBox(color: Colors.black12);
                },
                errorBuilder: (context, error, stack) => const SizedBox.shrink(),
              ),
            ),
          ),

        // Subtle tilted decorative panels (reduced contrast so artwork remains visible)
        Positioned(
          left: -24,
          top: 40,
          child: Transform.rotate(
            angle: -0.20,
            child: Container(width: 200, height: 120, decoration: BoxDecoration(color: light ? Colors.black12 : Colors.white10, borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Positioned(
          right: -40,
          bottom: -6,
          child: Transform.rotate(
            angle: 0.15,
            child: Container(width: 230, height: 140, decoration: BoxDecoration(color: light ? Colors.black12 : Colors.black12, borderRadius: BorderRadius.circular(28))),
          ),
        ),

        // Center title and subtitle
        Positioned(
          left: 18,
          right: 18,
          bottom: 56,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Gallery — Curated Works', style: TextStyle(color: light ? Colors.black87 : Colors.white, fontSize: 28, fontWeight: FontWeight.bold, shadows: light ? null : [const Shadow(blurRadius: 6, color: Colors.black26, offset: Offset(0,2))])),
            const SizedBox(height: 6),
            Text('Curated selection of contemporary and classic works', style: TextStyle(color: light ? Colors.black54 : Colors.white70)),
          ]),
        ),

        // Decorative floating avatar 
          Positioned(
            right: 18,
            top: 32,
            child: CircleAvatar(
              radius: 44,
              backgroundColor: light ? Colors.black12 : Colors.white,
              child: ClipOval(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/profile.jpg', fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.person, size: 48)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
