# Plan: Add 2 buttons above "Daftar Manhwa" on HomePage, navigating to news_page

## Goal
Add two buttons above the "Daftar Manhwa" heading on `lib/book/home_page.dart` that navigate to a new news page at `lib/news/news_page.dart` (currently empty), using the existing `Navigator.push` pattern already used for `DetailPage`.

## Current context / assumptions
- Home page is `lib/book/home_page.dart`: a `StatelessWidget` (HomePage) wrapping a `Scaffold` whose body is a `SingleChildScrollView` containing a `Column`.
  - The literal text "Daftar Manhwa" sits at line 39, inside a `const Padding` with `Text` style `fontSize 18, fontWeight w500`.
  - Below it is a `ListView.builder` (itemCount = `listBook.length`) showing the komik list.
- The news module is **empty**: `lib/news/news_page.dart` (0 bytes), plus `client.dart`, `detail_news_page.dart`, `response_articles.dart` are all 0 bytes.
- Routing: `lib/main.dart` is a plain `MaterialApp` with `home: const HomePage()` — **no router package, no named routes**. Navigation is done imperatively via `Navigator.push(context, MaterialPageRoute(builder: ...))` (same pattern already used for the book list in home_page.dart).
- Existing navigation pattern in this file (book list item): `Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(book: book)))`.
- `pubspec.yaml` declares `flutter` SDK + `cupertino_icons` + `flutter_lints`. No router dependency installed. `flutter` SDK `^3.13.4`.
- Assets: `images/banner.webp`, `images/image1.webp`..`images/image9.webp` exist (untracked). `images/asset` folder referenced by home_page via `AssetImage("images/banner.webp")`.
- Test file `test/widget_test.dart` currently tests `MainApp` (counter smoke test). It references a `+` icon and `0`/`1` text that no longer exist in the real app, but is a valid widget-test scaffold.

## Architecture / proposed approach
- **Approach: imperative navigation via `Navigator.push` + `MaterialPageRoute`** — matches the only routing mechanism already in the app (home_page.dart uses it for DetailPage; main.dart has no router package). No new dependency, zero risk of breaking existing behavior.
- **Two buttons** are placed in a `Row` (or `Row` with `mainAxisAlignment`) **just before** the "Daftar Manhwa" `Padding`. Each is a `TextButton` styled to look like a section switch.
  - Button A label: **"News"** → `Navigator.push` → `MaterialPageRoute` → `NewsPage()` (new widget).
  - Button B label: **"Komik"** → `Navigator.push` → `MaterialPageRoute` → `KomikPage()` (re-shows the existing manhwa list). *This is a proposed default; the actual second destination is unconfirmed and can be swapped without touching the architecture.*
- **News page**: `lib/news/news_page.dart` currently has no widget body. It must be given a minimal working page: a `Scaffold` with an `AppBar` and a `ListView` (or `SingleChildScrollView` + `Column`) rendering a static/news list. Since `client.dart`, `response_articles.dart`, `detail_news_page.dart` are all empty, there is no real data source; the page will render hard-coded placeholder news so the button wired, then data can be swapped in later.
- **Routing note**: Because `main.dart` has no onGenerateRoute, navigation is page-type based (not named routes). This is fine for 2 extra buttons.

## Step-by-step tasks

### Task 1 — Write news_page.dart widget (headless widget)
**File:** `lib/news/news_page.dart`
Create the page widget that `Navigator.push` will instantiate. Keep it minimal but complete (Scaffold + AppBar + scrollable list).

```dart
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Berita"),
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text("Berita ${index + 1}"),
              subtitle: const Text("Ringkasan singkat berita num ${index + 1}."),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
```

**Verify:** `cd /home/maspati/Dokumen/mobileluqman && flutter analyze lib/news/news_page.dart` → must report 0 errors.

---

### Task 2 — Create KomikPage widget (optional placeholder for button B)
**File:** `lib/book/komik_page.dart`
Since button B's real destination is unresolved, create a stub that re-shows the existing manhwa list so the second button is functional out of the box. This avoids a dead button.

```dart
import 'package:flutter/material.dart';
import 'package:mobileluqman/book/book.dart';
import 'package:mobileluqman/book/detail_page.dart';

class KomikPage extends StatelessWidget {
  const KomikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Komik"),
      ),
      body: ListView.builder(
        itemCount: listBook.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final book = listBook[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(book: book),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(book.image, width: 60),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.categoryBook,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

**Verify:** `flutter analyze lib/book/komik_page.dart` → 0 errors.

---

### Task 3 — Add two buttons above "Daftar Manhwa" on home_page.dart
**File:** `lib/book/home_page.dart`
Locate the `//SubTitle` `Padding` (the "Daftar Manhwa" heading). Insert a new `Row` immediately before it, inside the same `Column`, so the buttons sit above the heading.

Replace lines 36-42 of home_page.dart:

```dart
              //SubTitle
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Daftar Manhwa",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
```

with:

```dart
              //Section buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewsPage()),
                      );
                    },
                    icon: const Icon(Icons.article),
                    label: const Text("News"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KomikPage()),
                      );
                    },
                    icon: const Icon(Icons.book),
                    label: const Text("Komik"),
                  ),
                ],
              ),

              //SubTitle
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Daftar Manhwa",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
```

**Verify:** `flutter analyze lib/book/home_page.dart` → 0 errors.

---

### Task 4 — Register KomikPage import in home_page.dart
`lib/book/home_page.dart` already imports `detail_page.dart` (line 3). Add `komik_page.dart` to the import list.

Line 3 currently:
```dart
import 'package:mobileluqman/book/detail_page.dart';
```

Change to:
```dart
import 'package:mobileluqman/book/detail_page.dart';
import 'package:mobileluqman/book/komik_page.dart';
```

**Verify:** `flutter analyze lib/book/home_page.dart` → 0 errors.

---

### Task 5 — Wire the news button to the empty page (if the user intends to show content in news_page)
`lib/news/news_page.dart` is empty right now. Task 1 gives it a minimal working body. If the user intends to show real news content later, they will replace the placeholder `ListView.builder` with a real data source. No routing change needed — the button already points at `NewsPage()`.

**Verify:** Run `flutter run` and tap the "News" button → the navigation succeeds and shows the news page.

---

### Task 6 — Add a widget test for the home page navigation (optional but recommended)
**File:** `test/widget_test.dart`
Extend the existing widget test to verify both buttons are present and tapping "News" pushes the news page.

Add after the existing `testWidgets` block (or replace the counter test since it is stale):

```dart
testWidgets('HomePage shows News and Komik buttons', (WidgetTester tester) async {
  await tester.pumpWidget(const MainApp());

  // Both buttons must exist
  expect(find.text('News'), findsOneWidget);
  expect(find.text('Komik'), findsOneWidget);
});

testWidgets('Tapping News navigates to news page', (WidgetTester tester) async {
  await tester.pumpWidget(const MainApp());

  await tester.tap(find.text('News'));
  await tester.pumpAndSettle();

  expect(find.text('Berita'), findsOneWidget);
});

testWidgets('Tapping Komik navigates to komik page', (WidgetTester tester) async {
  await tester.pumpWidget(const MainApp());

  await tester.tap(find.text('Komik'));
  await tester.pumpAndSettle();

  expect(find.text('Komik'), findsOneWidget);
});
```

**Verify:** `flutter test` → all tests pass.

---

## Tests / validation
Run, in order, from repo root `/home/maspati/Dokumen/mobileluqman`:

| Step | Command | Expected output |
|------|---------|-----------------|
| Analyze news page | `flutter analyze lib/news/news_page.dart` | "0 errors" |
| Analyze komik page | `flutter analyze lib/book/komik_page.dart` | "0 errors" |
| Analyze home page | `flutter analyze lib/book/home_page.dart` | "0 errors" |
| Analyze entire project | `flutter analyze` | "0 errors" |
| Run app + manual tap | `flutter run` → tap "News" button | news page opens; tap "Komik" → komik page opens |
| Widget tests | `flutter test` | all tests pass |

---

## Risks, tradeoffs, and open questions

**Risks**
- `main.dart` has no router package. Adding buttons that navigate via `Navigator.push` is low-risk, but if the user later wants deep links or named routes, a router must be added separately.
- The news module's data files (`client.dart`, `detail_news_page.dart`, `response_articles.dart`) are empty. The news page currently renders hard-coded placeholders; real content requires wiring a data source into `NewsPage`.
- Widget test file `test/widget_test.dart` currently contains a stale "counter" test that no longer matches the app (no `+` icon, no `0`/`1` text). This does not block the plan but should be cleaned up; I left it in place and only appended new tests so the existing scaffold is not broken.

**Tradeoffs**
- Using `TextButton.icon` for the two buttons keeps the change small and readable. A `ElevatedButton` or `OutlinedButton` would give stronger visual emphasis but changes the look. `TextButton` is the least disruptive to the existing UI style.
- `Row` with `spaceEvenly` distributes the two buttons evenly. On very narrow screens this could crowd the text; acceptable for target device widths.
- I proposed the second button as "Komik" (re-shows the manhwa list) as a **default only**. If the user wants a different second destination (e.g., a favicon page, a settings page, or another section), only Task 3's second `Navigator.push` target changes — the architecture stays the same.

**Open questions (to confirm with user before/during execution)**
1. What should the **second button** navigate to? I defaulted to "Komik" (re-shows the manhwa list). Confirm or give an exact destination.
2. Does the user want the news page to show **real data** (JSON/API) or just a placeholder now? The plan ships a placeholder so the button works; real data can be added later without changing the routing.
3. Should the buttons be labelled **"News" / "Komik"** (English), or in **Bahasa** ("Berita" / "Komik")? The existing UI text is mixed (e.g., "Daftar Manhwa", "Komikers Si Luqman"). I used English labels; confirm.
