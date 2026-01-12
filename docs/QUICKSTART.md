# Quick Start Guide

## First Time Setup

### 1. Install Dependencies

```bash
cd echo_music
flutter pub get
```

### 2. Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Run the App

```bash
# For Android
flutter run -d android

# For Windows
flutter run -d windows

# For Linux
flutter run -d linux
```

---

## Project Structure at a Glance

```
echo_music/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── core/                        # Shared code
│   │   ├── constants/               # App constants
│   │   └── theme/                   # Theme & styling
│   ├── data/                        # Data layer
│   │   ├── models/                  # Data models (Song, Album, etc.)
│   │   ├── repositories/            # Data repositories
│   │   └── services/                # External services
│   ├── domain/                      # Business logic
│   └── presentation/                # UI layer
│       ├── providers/               # Riverpod state
│       ├── pages/                   # Screens
│       └── widgets/                 # Reusable UI
├── docs/                            # Documentation
├── pubspec.yaml                     # Dependencies
└── analysis_options.yaml            # Linting rules
```

---

## Key Technologies

| Technology | Purpose |
|------------|---------|
| **Riverpod** | State management |
| **Hive** | Local database |
| **just_audio** | Audio playback |
| **audio_service** | Background playback |
| **id3_ffi** | Metadata extraction |
| **phosphor_flutter** | Icons |
| **Freezed** | Immutable models |

---

## Common Tasks

### Add a New Model

1. Create file in `lib/data/models/`
2. Use Freezed annotation:
   ```dart
   @freezed
   class MyModel with _$MyModel {
     const factory MyModel({
       required String id,
       String? name,
     }) = _MyModel;

     factory MyModel.fromJson(Map<String, dynamic> json) =>
         _$MyModelFromJson(json);
   }
   ```
3. Run: `dart run build_runner build`

### Add a New Provider

1. Create file in `lib/presentation/providers/`
2. Use Riverpod annotation:
   ```dart
   @riverpod
   class MyController extends _$MyController {
     @override
     MyState build() => MyState.initial();

     Future<void> doSomething() async {
       // Implementation
     }
   }
   ```
3. Run: `dart run build_runner build`

### Add a New Page

1. Create file in `lib/presentation/pages/`
2. Extend `ConsumerStatefulWidget`:
   ```dart
   class MyPage extends ConsumerStatefulWidget {
     const MyPage({super.key});

     @override
     ConsumerState<MyPage> createState() => _MyPageState();
   }

   class _MyPageState extends ConsumerState<MyPage> {
     @override
     Widget build(BuildContext context) {
       return Scaffold(...);
     }
   }
   ```

---

## Development Workflow

### Watch Mode (Recommended for Development)

```bash
# Terminal 1: Watch for code generation changes
dart run build_runner watch --delete-conflicting-outputs

# Terminal 2: Run the app
flutter run
```

### Hot Reload

While the app is running, press:
- `r` - Hot reload
- `R` - Hot restart
- `q` - Quit

---

## Code Generation Files

When you run `build_runner`, these files are generated:
- `*.g.dart` - JSON serialization, Hive adapters
- `*.freezed.dart` - Freezed model code
- `*.riverpod.dart` - Riverpod provider code

**Note**: Never edit these files manually!

---

## Troubleshooting

### Build runner fails
```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### App won't run
```bash
flutter clean
flutter pub get
flutter run
```

### Type errors
```bash
flutter analyze
```

---

## Next Steps

1. Read `docs/ARCHITECTURE.md` for architecture details
2. Read `docs/API_REFERENCE.md` for API documentation
3. Read `docs/UI_DESIGN.md` for UI guidelines
4. Check `docs/ROADMAP.md` for development progress

---

## Useful Commands

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Run tests
flutter test

# Build for release
flutter build apk           # Android
flutter build windows       # Windows
flutter build linux         # Linux
```
