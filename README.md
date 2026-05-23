# Movies Explorer

A Flutter application that lets you browse movies across four categories — Trending, Popular, Top Rated, and Upcoming — powered by the TMDB API.

## Features

- **Four movie categories** on the home screen: Trending (Now Playing), Popular, Top Rated, and Upcoming
- **Movie detail pages** for each category with full info (poster, rating, overview, release date)
- **Search** across all categories from a single screen
- **Offline caching** with Hive — data loads from local storage when available, reducing redundant API calls
- **BLoC state management** — each category has its own Bloc for clean separation of concerns
- **Cached network images** for smooth poster loading

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | flutter\_bloc |
| API | TMDB (The Movie Database) |
| Local Cache | Hive + hive\_flutter |
| Networking | http |
| Image Loading | cached\_network\_image |
| Fonts | google\_fonts |

## Project Structure

```
lib/
├── constants/          # App colors, API key, image base URL
├── models/             # MovieModel + Hive adapter
├── repository/         # RepoApi — all TMDB API calls + cache logic
├── utils/              # CacheManager (Hive read/write helper)
└── presentation/
    ├── home/           # Home screen, search screen, shared widgets
    ├── trending/       # Trending (Now Playing) list + detail
    ├── popular/        # Popular list + detail
    ├── top_rated/      # Top Rated list + detail
    └── upcoming/       # Upcoming list + detail
```

## Getting Started

### Prerequisites

- Flutter SDK `^3.5.1`
- A free TMDB API key from [themoviedb.org](https://www.themoviedb.org/settings/api)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/PranithVarma/Movies_db.git
   cd Movies_db
   ```

2. Add your TMDB API key in `lib/constants/constants.dart`:
   ```dart
   static const apiKey = 'YOUR_API_KEY_HERE';
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Screenshots

> Add screenshots here after running the app on a device or emulator.

## License

This project is for learning/assignment purposes.
