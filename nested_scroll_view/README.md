# NestedScrollView — Quick Demo

A minimal Flutter demo showing a collapsing header (SliverAppBar + FlexibleSpace) coordinated with inner scrolling content using `NestedScrollView`.

## Getting Started

### Prerequisites
- Flutter SDK installed and on your PATH
- A web browser (Chrome) or Android emulator/device

### Run the app

```bash
flutter analyze
flutter run -d chrome
```

For Android:
```bash
emulator -avd Pixel_7 -gpu host
flutter run
```

## Demo Points

- **Authenticity**: Header artwork preserves context and brand presence when expanded.
- **Condition**: Smooth collapse/expand transitions with safe image loading.
- **Popularity**: Gallery grid layout helps surface important items; header interaction guides discovery.

## Project Structure

```
lib/
  main.dart                 # App entry point
  src/
    nested_scroll_demo.dart # Main NestedScrollView implementation
    header_artwork.dart     # Header widget with artwork and avatar
    gallery_card.dart       # Gallery grid item widget
    constants.dart          # Shared constants (colors, etc.)
```

## Screenshot

Add a screenshot to `assets/screenshot.png` after running the app.

## Sources & Attribution

Code built using Flutter's official documentation on SliverAppBar and NestedScrollView. No external code tutorials were directly copied.
