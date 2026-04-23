# 👗 Fashion Store

A modern **Flutter** mobile application for an online fashion retail experience. Built as a full-featured e-commerce app with product browsing, cart management, checkout flow, and order tracking.

> CIT211 Mobile Software Development Phase 1 Project

---

## 📱 Screenshots

| Home | Product Listing | Product Details | Cart | Checkout |
|------|----------------|-----------------|------|----------|
| <img width="200" height="420" alt="Home" src="https://github.com/user-attachments/assets/3e9cb30f-4c0c-42f7-a4b9-08e064979d05" /> | <img width="200" height="420" alt="Product Listing" src="https://github.com/user-attachments/assets/506180a9-8d68-4438-940d-6a562bd84f83" /> | <img width="200" height="420" alt="Product Details" src="https://github.com/user-attachments/assets/da2c9c83-c1c8-4b80-8876-1db6a6e17608" /> | <img width="200" height="420" alt="Cart" src="https://github.com/user-attachments/assets/ef54f8d6-abcc-4ffa-82ce-63cfeb8245b0" /> | <img width="200" height="420" alt="Checkout" src="https://github.com/user-attachments/assets/2eeb88dd-3811-46c1-8577-36ce79dfad2e" /> |

---

## ✨ Features

- 🔐 **Authentication** — Login and registration screens
- 🏠 **Home Screen** — Featured collections, banners, and search functionality
- 🛍️ **Product Listing** — Browse products by category with filtering
- 🔍 **Product Details** — Size and color selection, detailed product view
- 🛒 **Shopping Cart** — Add/remove items, quantity management
- 💳 **Checkout** — Complete order placement flow
- 📦 **Orders** — Order history and status tracking
- 👤 **Profile** — User profile management
- 🎨 **Custom Theme** — Consistent design system via `AppTheme`

---

## 🗂️ Project Structure

```
fashion_store/
├── lib/
│   ├── main.dart                  # App entry point & Provider setup
│   ├── models/
│   │   ├── models.dart            # Product, CartItem, Order models & mock data
│   │   └── cart_provider.dart     # Cart state management (ChangeNotifier)
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── main_screen.dart       # Shell with bottom navigation
│   │   ├── home_screen.dart
│   │   ├── product_listing_screen.dart
│   │   ├── product_details_screen.dart
│   │   ├── cart_screen.dart
│   │   ├── checkout_screen.dart
│   │   ├── orders_screen.dart
│   │   └── profile_screen.dart
│   ├── widgets/
│   │   ├── product_card.dart      # Reusable product card widget
│   │   └── bottom_nav.dart        # Custom bottom navigation bar
│   └── theme/
│       └── app_theme.dart         # Global theme configuration
├── assets/
│   └── images/                    # Local image assets
├── android/                       # Android platform files
├── ios/                           # iOS platform files
└── pubspec.yaml
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x |
| Language | Dart ≥ 3.0.0 |
| State Management | Provider (`ChangeNotifier`) |
| Fonts | `google_fonts` ^6.1.0 |
| Image Loading | `cached_network_image` ^3.3.0 |
| Carousel | `carousel_slider` ^4.2.1 |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (≥ 3.0.0)
- Dart SDK ≥ 3.0.0
- Android Studio / Xcode (for emulators)
- A connected device or emulator

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/suhair-hue/fashion-store-project-new.git
cd fashion_store

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0          # Custom typography
  cached_network_image: ^3.3.0  # Efficient network image loading
  carousel_slider: ^4.2.1       # Home screen image carousel
  provider: ^6.x.x              # State management

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

---

## 🏛️ Architecture

The app follows a **Provider-based** state management pattern:

- **Models** — Plain Dart classes for `Product`, `CartItem`, and `Order`, plus a `MockData` class that serves as an in-memory data source.
- **CartProvider** — A `ChangeNotifier` that manages cart state globally across screens.
- **Screens** — Stateful/Stateless widgets consuming the provider via `context.watch` / `context.read`.
- **Widgets** — Reusable UI components (`ProductCard`, `BottomNav`) decoupled from business logic.

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is for educational purposes (CIT211) Mobile Software Development. All rights reserved.

---

## 👤 Author

**Muhammad suhair**  
GitHub:(https://github.com/suhair-hue/fashion-store-project-new.git)
