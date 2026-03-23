# 021 Trade Flutter Assignment (Watchlist Reorder with BLoC)

This project implements the watchlist reorder flow from the shared 021 Trade references using Flutter and BLoC architecture.

The core requirement is implemented as requested:
- reorder stocks in watchlist edit mode
- commit changes only on save
- keep a sample local watchlist data structure

## Assignment Coverage

### Functional requirement
- Reordering stock positions is supported in edit mode using drag-and-drop.
- The home watchlist is updated only after tapping `Save Watchlist`.
- Draft edits are isolated from persisted home state until save.

### Focus areas from the assignment email
- UI/UX quality: implemented a close visual match for watchlist home + edit screens.
- Responsiveness: mobile-first layout with safe-area handling and adaptive list behavior.
- Code quality: feature-based organization, immutable models, explicit state transitions.
- Code reusability: shared widgets for market strip, tabs, list rows, and bottom nav shell.
- Type safety: strongly typed entities (`Watchlist`, `StockQuote`) and typed bloc/cubit states.
- Correct BLoC usage: `WatchlistBloc` for source-of-truth state, `EditWatchlistCubit` for draft edits.
- Project structuring: separated `core`, `watchlist`, and `edit_watchlist` responsibilities.

## Tech Stack
- Flutter 3.x
- `flutter_bloc`
- `equatable`
- `intl`

## Architecture Overview

The app uses two state layers:

1. `WatchlistBloc` (persisted screen state)
- loads sample watchlist data
- handles selected tab changes
- applies saved edited watchlist back to source-of-truth state

2. `EditWatchlistCubit` (draft edit state)
- initialized from selected watchlist
- handles title changes, reorder, delete
- computes `isDirty` and `canSave`
- returns a drafted `Watchlist` on save

This separation ensures the home screen remains stable while editing is in progress.

## User Flow
1. App loads watchlists and shows `Watchlist 1`.
2. User taps `Sort by` on the home screen (as in the reference flow) to enter edit mode.
3. User reorders/deletes/renames in edit screen.
4. User taps `Save Watchlist`.
5. `WatchlistSaved` event updates `WatchlistBloc` and home screen reflects new order/title.

## Project Structure

```text
lib/
  core/
    theme/
      app_colors.dart
      app_theme.dart
    utils/
      formatters.dart
  features/
    watchlist/
      data/
        watchlist_repository.dart
      domain/models/
        stock_quote.dart
        watchlist.dart
      presentation/
        bloc/
          watchlist_bloc.dart
          watchlist_event.dart
          watchlist_state.dart
        pages/
          watchlist_page.dart
        widgets/
          market_summary_card.dart
          watchlist_tab_bar.dart
          watchlist_stock_tile.dart
          bottom_nav_shell.dart
    edit_watchlist/
      presentation/
        cubit/
          edit_watchlist_cubit.dart
          edit_watchlist_state.dart
        pages/
          edit_watchlist_page.dart
        widgets/
          edit_watchlist_tile.dart

test/
  features/
    watchlist/
      watchlist_bloc_test.dart
    edit_watchlist/
      edit_watchlist_cubit_test.dart
  widget_test.dart
```

## Data Model

### `StockQuote`
- `id`
- `symbol`
- `subtitle`
- `price`
- `change`
- `changePercent`
- `priceDecimals`

### `Watchlist`
- `id`
- `title`
- ordered `List<StockQuote>`

Sample data is currently local and in-memory (`WatchlistRepository`).

## BLoC Components

### `WatchlistEvent`
- `WatchlistLoadRequested`
- `WatchlistSelected`
- `WatchlistSaved`

### `WatchlistState`
- `status` (`initial`, `loading`, `loaded`)
- `watchlists`
- `selectedWatchlistId`

### `EditWatchlistState`
- `initialWatchlist`
- `draftTitle`
- `draftStocks`
- computed `isDirty`
- computed `canSave`
- computed `draftWatchlist`

## UI Notes

Implemented screens:
- Home watchlist screen (top market strip, search, tabs, sort/edit entry point, stock list, bottom nav shell)
- Edit watchlist screen (drag handles, delete, rename, save/discard behavior)

Reference-specific behavior:
- No separate edit icon on home.
- `Sort by` is used as the entry point to watchlist edit mode.

## Test Coverage

### Unit tests (`EditWatchlistCubit`)
- reorder upward
- reorder downward
- list integrity after reorder
- delete in draft without mutating source

### Bloc tests (`WatchlistBloc`)
- load sample watchlists
- save reordered watchlist into source state
- unchanged state when no save event occurs

### Widget tests
- renders home stock rows from bloc state
- opens edit flow from `Sort by`
- save persists reordered result
- save persists updated watchlist title

## Run Instructions

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Tradeoffs / Scope Choices
- Data persistence to disk/server is out of scope for this assignment and intentionally omitted.
- Search and bottom navigation interactions are present as UI shell components.
- The implementation prioritizes the watchlist reorder/edit/save flow and BLoC correctness.
