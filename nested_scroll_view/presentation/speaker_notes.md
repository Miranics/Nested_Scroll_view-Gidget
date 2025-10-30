Slide 1 — Title

- Cue: Hi — I’ll show what NestedScrollView does and why it’s useful.
- Talking points: Briefly state the goal — keep an expressive header while letting content take the stage.
- Time: 15-25s

---

Slide 2 — Problem & Motivation

- Cue: Describe the UX problem on small screens — too much or too little header.
- Talking points:
	- Explain when a large header is useful (artwork, branding, hero content).
	- Explain why collapsing is better than always pinned or always hidden.
- Time: 40-60s

---

Slide 3 — Architecture

- Cue: Walk the diagram from outer header to inner scrollables.
- Talking points:
	- SliverAppBar controls the flexible header area.
	- NestedScrollView stitches outer slivers with inner scroll views.
	- Inner TabBarView/ListView are independent but coordinated.
- Time: 50-70s

---

Slide 4 — Key components

- Cue: Explain each API briefly and why it matters.
- Talking points:
	- SliverAppBar: expandedHeight, flexibleSpace, pinned — used to make the header large but collapsible.
	- NestedScrollView: headerSliverBuilder + body — coordinates the scroll positions.
	- TabBarView: multiple inner screens; each can be a ListView/GridView.
- Time: 50-70s

---

Slide 5 — Code: SliverAppBar

- Cue: Show the SliverAppBar snippet. Point at expandedHeight and flexibleSpace.
- Talking points: discuss safe image loading (loadingBuilder / errorBuilder) for header artwork and using a local avatar.
- Time: 60-80s

---

Slide 6 — Code: NestedScrollView + Tabs

- Cue: Walk the NestedScrollView / TabBarView snippet. Explain headerSliverBuilder and the body.
- Talking points: show how switching tabs keeps inner scroll state and how the header reacts.
- Time: 60-90s

---

Slide 7 — Demo steps (live)

- Cue: Outline what you will do during the live demo.
- Talking points:
	- Start on Gallery; scroll to collapse header.
	- Switch to Attributes and show independent scroll.
	- Scroll up to re-expand header.
	- Note image loading fallbacks and smoothness.
- Time: 90-120s (live demo time can vary)

---

Slide 8 — Takeaway & Resources

- Cue: Wrap up with the practical takeaway and where code lives.
- Talking points: mention the files in the repo (`lib/src/nested_scroll_demo.dart`, `header_artwork.dart`, `gallery_card.dart`) and resources (Flutter docs for SliverAppBar / NestedScrollView).
- Time: 20-30s

---

Timing guidance

- Target total run including a short demo: ~6–8 minutes. Remove or shorten the live demo to fit tighter constraints.
