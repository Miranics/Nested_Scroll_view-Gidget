# NestedScrollView Widget Study

This project demonstrates the Flutter `NestedScrollView` widget ;  a container that coordinates scrolling between an outer sliver-based header and inner scrollable content.

## What is NestedScrollView?

`NestedScrollView` allows a large, collapsible header (built with slivers like `SliverAppBar`) to expand and collapse smoothly while inner scrollable content (e.g., `TabBarView`, `ListView`, `GridView`) scrolls independently and in sync. It's ideal for:
- Large hero headers that collapse on scroll
- Apps with tabs where the header changes but remains coordinated
- Gallery or content apps where a prominent hero image transitions smoothly

## Implementation

The widget is used in `lib/src/nested_scroll_demo.dart` with:
- **Outer slivers**: A `SliverAppBar` with `expandedHeight: 320` and `FlexibleSpaceBar` containing artwork and title.
- **Inner scrollables**: A `TabBarView` with three tabs (Gallery, Attributes, Chat), each containing a `GridView` or `ListView`.
- **Coordination**: The `NestedScrollView` ensures that as you scroll any inner content, the outer header expands/collapses smoothly.

## Example Use Case

This project demonstrates the pattern using a minimal art gallery app:
- Header shows curated artwork and gallery title (expands/collapses on scroll).
- Gallery tab displays a grid of artworks.
- Attributes and Chat tabs show additional content.
- All tabs scroll independently but remain coordinated with the collapsible header.

## Run

```bash
flutter analyze
flutter run -d chrome
```

Or on Android:
```bash
emulator -avd Pixel_7 -gpu host
flutter run
```

## Screenshot

![App screenshot](nested_scroll_view\assets\screenshot.png)

## Key Files

- `lib/src/nested_scroll_demo.dart` — Main `NestedScrollView` implementation and layout.
- `lib/src/header_artwork.dart` — Header widget with artwork, gradient, and avatar.
- `lib/src/gallery_card.dart` — Individual gallery item widget.
- `lib/src/constants.dart` — Shared UI constants.

## Key Properties Used

- `NestedScrollView.headerSliverBuilder` — Defines outer slivers (the header).
- `NestedScrollView.body` — Inner scrollable content.
- `SliverAppBar.pinned: true` — Header remains visible when collapsed.
- `SliverAppBar.expandedHeight` — Height of the expanded header.
- `FlexibleSpaceBar.background` — Large artwork shown when expanded.

## Sources 

Code built using Flutter's official documentation on `SliverAppBar`, `NestedScrollView`, and sliver-based layouts.
