import 'package:flutter/material.dart';

// Soft accent for gallery / UI elements (milk / warm beige)
const Color _accent = Color(0xFFBFAF9E);

/// A concise but visually distinct demo of NestedScrollView styled as
/// an art gallery. The example focuses on demonstrating coordinated
/// scrolling between an expanding `SliverAppBar` and inner scrollables.
class NestedScrollDemo extends StatelessWidget {
  /// Optional image sources (asset paths or http URLs). If empty, the
  /// demo uses placeholder network images so the layout is visible.
  const NestedScrollDemo({super.key, this.imagePaths = const []});

  final List<String> imagePaths;

  static const _tabs = ['Gallery', 'Attributes', 'Chat'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F6F2),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) => [
            SliverAppBar(
              pinned: true,
              expandedHeight: 320,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(background: _HeaderArtwork.light()),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(64),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  color: Colors.transparent,
                  child: _buildTabBar(light: true),
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildGalleryTab(),
              _buildStatsTab(),
              _buildChatTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar({bool light = false}) {
    final bg = light ? Colors.white : const Color.fromRGBO(255, 255, 255, 0.06);
    final border = light ? Colors.black12 : Colors.white12;
    final indicator = BoxDecoration(
      color: light ? const Color(0xFFEDE7E0) : null,
      borderRadius: BorderRadius.circular(10),
    );

    return Container(
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: border)),
      child: TabBar(
        indicator: indicator,
        labelColor: light ? Colors.black87 : Colors.black,
        unselectedLabelColor: light ? Colors.black54 : Colors.white70,
        tabs: _tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  Widget _buildGalleryTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxis = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 3 : 2);
      final itemCount = imagePaths.isNotEmpty ? imagePaths.length : 12;

      return GridView.builder(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxis,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemCount: itemCount,
        itemBuilder: (context, i) {
          final src = imagePaths.isNotEmpty ? imagePaths[i] : 'https://picsum.photos/seed/art_$i/800/1200';
          return _GalleryCard(index: i, imageSource: src);
        },
      );
    });
  }

  Widget _buildStatsTab() {
    // Attributes relevant to an art gallery — each shows a simple score.
    const attributes = [
      'Authenticity',
      'Condition',
      'Popularity',
      'Rarity',
      'Preservation',
      'Frame Quality',
      'Exhibition History',
      'Market Value',
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: attributes.length,
      itemBuilder: (context, i) {
        // Demo values: deterministic but varied so bars look different.
        final value = ((i * 37) % 91) + 9; // range ~9..99
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(radius: 26, backgroundColor: _accent, child: Text('${i + 1}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(attributes[i], style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(value: value / 100.0, color: _accent, backgroundColor: const Color.fromRGBO(0, 0, 0, 0.04), minHeight: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text('$value%', style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatTab() {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: 20,
      itemBuilder: (context, i) {
        final mine = i % 3 == 0;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: mine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!mine) CircleAvatar(radius: 16, backgroundColor: Colors.black12, child: const Icon(Icons.person, size: 18)),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(color: mine ? _accent : Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.03), blurRadius: 6)]),
                  child: Text(mine ? 'Quick reply from you (#$i)' : 'Message number $i — a sample bubble to show nested scroll behavior.', style: TextStyle(color: mine ? Colors.black87 : Colors.black87)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Header artwork used inside FlexibleSpaceBar. Uses soft, gallery-like
/// colours for the light variant.
class _HeaderArtwork extends StatelessWidget {
  const _HeaderArtwork({this.light = false});

  final bool light;

  /// Convenience constructor for the light variant used by the demo.
  factory _HeaderArtwork.light() => const _HeaderArtwork(light: true);

  @override
  Widget build(BuildContext context) {
    // Different palettes depending on light/dark mode for the header.
    final bgColors = light ? const [Color(0xFFFDF9F5), Color(0xFFF3EEE8), Color(0xFFEDE7E0)] : const [Color(0xFF0F3460), Color(0xFF6D0EB5), Color(0xFF35D0BA)];

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: bgColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Tilted, semi-transparent panels for depth
        Positioned(
          left: -40,
          top: 40,
          child: Transform.rotate(
            angle: -0.25,
            child: Container(
              width: 240,
              height: 160,
              decoration: BoxDecoration(
                color: light ? Colors.black12 : Colors.white10,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
        Positioned(
          right: -60,
          bottom: -10,
          child: Transform.rotate(
            angle: 0.20,
            child: Container(
              width: 300,
              height: 180,
              decoration: BoxDecoration(
                color: light ? Colors.black12 : Colors.black12,
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),
        ),
        // Center title and subtitle
        Positioned(
          left: 18,
          right: 18,
          bottom: 56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gallery — Curated Works', style: TextStyle(color: light ? Colors.black87 : Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                'A minimal NestedScrollView demo styled as an art gallery',
                style: TextStyle(color: light ? Colors.black54 : Colors.white70),
              ),
            ],
          ),
        ),
        // Decorative floating avatar
        Positioned(
          right: 18,
          top: 42,
          child: CircleAvatar(
            radius: 36,
            backgroundColor: light ? Colors.black12 : Colors.white,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: light ? const Color(0xFFBFAF9E) : const Color(0xFF6D0EB5),
              child: Icon(Icons.brush, color: light ? Colors.white70 : Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

/// Single gallery card used in the grid. Supports network URLs and asset paths.
class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.index, required this.imageSource});

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
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Text('Artwork #${index + 1}', style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text('Artist name', style: TextStyle(color: Colors.black54, fontSize: 12))]),
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

    return Image.asset(src, fit: BoxFit.cover);
  }
}

