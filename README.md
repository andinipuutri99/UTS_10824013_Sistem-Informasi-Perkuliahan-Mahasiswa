# Kampus!n — Flutter App

Andini Putri Yani (10824013)

# Deskripsi Aplikasi
Kampus!n merupakan aplikasi mobile berbasis flutter dan dart yang dirancang untuk 
membantu mahasiswa mengakses informasi dasar perkuliahan.

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

<img width="203" height="380" alt="Screenshot 2026-05-19 124641" src="https://github.com/user-attachments/assets/fc227ff9-b65d-435c-a321-a78bf16a8f10" />
<img width="192" height="361" alt="Screenshot 2026-05-19 133738" src="https://github.com/user-attachments/assets/b91717eb-0c41-4450-a3da-800831d3e6d3" />
<img width="212" height="397" alt="Screenshot 2026-05-19 135600" src="https://github.com/user-attachments/assets/0685d087-274c-4d56-9b05-640fc07ec167" />
<img width="192" height="361" alt="Screenshot 2026-05-19 133806" src="https://github.com/user-attachments/assets/dde2eddb-e45e-4533-ace2-36a23b7f95f9" />


