# Kampus!n — Flutter App

Konversi dari React/TypeScript ke **Dart Flutter**.

## Struktur Proyek

```
lib/
├── main.dart                      # Entry point + AuthGate
├── constants/
│   ├── app_theme.dart             # Warna, tema, font
│   └── mock_data.dart             # Data dummy (schedule, news)
├── models/
│   └── user_model.dart            # UserProfile, ScheduleItem, NewsItem
├── providers/
│   └── user_provider.dart         # State management (pengganti UserContext)
├── screens/
│   ├── layout_screen.dart         # Shell dengan BottomNav + IndexedStack
│   ├── login_screen.dart          # Halaman login
│   ├── register_screen.dart       # Halaman registrasi
│   ├── forgot_password_screen.dart# Reset password (multi-step)
│   ├── dashboard_screen.dart      # Dashboard utama
│   ├── schedule_screen.dart       # Jadwal kuliah
│   ├── news_screen.dart           # Berita kampus
│   └── profile_screen.dart        # Profil mahasiswa
└── widgets/
    ├── app_card.dart              # AppCard, InputField, PrimaryButton
    └── bottom_nav.dart            # Bottom navigation bar
```

## Cara Setup

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Jalankan di emulator/device

```bash
flutter run
```

### 3. Build APK (Android)

```bash
flutter build apk --release
```

### 4. Build iOS

```bash
flutter build ios --release
```

## Mapping React → Flutter

| React/TypeScript            | Dart Flutter                              |
|-----------------------------|-------------------------------------------|
| `UserContext.tsx`           | `UserProvider` (ChangeNotifier + Provider)|
| `localStorage`              | `shared_preferences`                      |
| `react-router-dom`          | `Navigator.push` + `IndexedStack`         |
| `motion/react`              | `AnimatedContainer`, `AnimatedSwitcher`   |
| `useState` / `useEffect`    | `StatefulWidget` + `setState`             |
| `NavLink`                   | Custom `KampusinBottomNav`                |
| `app-card` (CSS class)      | `AppCard` widget                          |
| `input-field` (CSS class)   | `InputField` widget                       |
| `btn-primary` (CSS class)   | `PrimaryButton` widget                    |
| `MOCK_SCHEDULE`             | `mockSchedule` list                       |
| `MOCK_NEWS`                 | `mockNews` list                           |

## Dependencies

```yaml
provider: ^6.1.1          # State management
shared_preferences: ^2.2.2 # Persistent storage (pengganti localStorage)
google_fonts: ^6.1.0       # Plus Jakarta Sans font
```

## Notes

- Autentikasi masih **mock** — tidak ada backend nyata
- Untuk production, ganti `shared_preferences` dengan API call ke backend
- Avatar menggunakan DiceBear API (perlu internet)
- Gambar berita menggunakan Unsplash (perlu internet)
