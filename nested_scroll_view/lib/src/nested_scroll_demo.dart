import 'package:flutter/material.dart';
import 'constants.dart';
import 'header_artwork.dart';
import 'gallery_card.dart';

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
              flexibleSpace: FlexibleSpaceBar(background: HeaderArtwork.light(headerImageUrl: 'https://images.unsplash.com/photo-1504198453319-5ce911bafcde?auto=format&fit=crop&w=1200&q=80')),
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
          return GalleryCard(index: i, imageSource: src);
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
                CircleAvatar(radius: 26, backgroundColor: kAccent, child: Text('${i + 1}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(attributes[i], style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(value: value / 100.0, color: kAccent, backgroundColor: const Color.fromRGBO(0, 0, 0, 0.04), minHeight: 8),
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
                  decoration: BoxDecoration(color: mine ? kAccent : Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [const BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.03), blurRadius: 6)]),
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

