# LearnHub 📚

A cross-platform Learning Management System (LMS) built with Flutter, designed to help learners discover, enroll in, and track skill-based programs — accessible on mobile, web, and desktop.

---

## Project Vision

LearnHub bridges the gap between learners and quality skill-building content. The platform empowers users to take ownership of their learning journey through a clean, intuitive interface — whether they're on a phone during a commute or at a desktop at work.

---

## Objectives

- Provide a seamless login and onboarding experience for learners
- Allow learners to browse, search, and filter programs by category
- Show detailed program information with enrolment capability
- Display a personal dashboard with progress tracking and achievements
- Support responsive layouts across mobile, tablet, and desktop screens

---

## Target Users

| User Type | Description |
|-----------|-------------|
| **Learner** | A student or professional looking to build new skills through structured programs |
| **Admin** *(planned)* | Platform administrator who manages courses, users, and content |

---

## Key Features

### ✅ Week 2 — Functional UI Prototype (4 Interactive Screens)

| Screen | Features |
|--------|---------|
| **Login Screen** | Form validation, show/hide password, loading state, forgot password dialog, sign-up prompt |
| **Home Screen** | Personalised greeting, in-progress course card with progress bar, popular programs grid, achievements, notifications drawer, profile sheet, logout |
| **Program Listing** | Live search with clear button, category filter chips, result count, 8 programs, empty state |
| **Program Detail** | Curriculum list, what you'll learn checklist, bookmark toggle, enrol button with state change, share button |

### Navigation Flow
```
/login  ──── Log In ────►  /home
                              │
                    ┌─────────┴──────────┐
                    │                    │
              Program card          "See all" / Explore tab
                    │                    │
                    ▼                    ▼
            /program-detail      /programs (list)
                    │                    │
               Enrol Now           Program card
                    │                    │
               Snackbar ◄───────────────┘
                "Go Home" → /home
```

---

## App Screenshots

### 1. Login Screen
![Login Screen](docs/screenshots/login.png)

*Clean login form with email/password validation, show/hide password toggle, and brand panel on desktop.*

### 2. Home Dashboard
![Home Screen](docs/screenshots/home.png)

*Personalised dashboard with in-progress course card (75% progress), popular programs grid, and achievement stats.*

### 3. Program Listing
![Program Listing](docs/screenshots/programs.png)

*Searchable, filterable program catalog with 8 programs across 4 categories.*

### 4. Program Detail
![Program Detail](docs/screenshots/detail.png)

*Full program page with curriculum, learning outcomes checklist, and interactive enrol button.*

---

## Project Structure

```
LearnHub/
├── lib/
│   ├── main.dart                     # App entry + animated route transitions
│   ├── screens/
│   │   ├── login_screen.dart         # Form validation, loading state, dialogs
│   │   ├── home_screen.dart          # Dashboard, bottom nav, notifications
│   │   ├── program_list_screen.dart  # Search, filter, 8 programs
│   │   └── program_detail_screen.dart # Curriculum, enrol, bookmark
│   ├── theme/
│   │   └── app_theme.dart            # Design tokens — colors, spacing, radii
│   └── utils/
│       └── responsive.dart           # Breakpoint helpers & ResponsiveCenter
├── docs/
│   ├── app_proposal.html             # Week 1 proposal document
│   ├── LearnHub_App_Proposal_Week1.pdf
│   └── screenshots/                  # Week 2 app screenshots
├── android/
├── ios/
├── web/
├── windows/
├── pubspec.yaml
└── README.md
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.44 (Dart 3.12) |
| UI | Material Design 3 |
| State | StatefulWidget (local state) |
| Navigation | Named routes with animated transitions |
| Responsive | Custom `Responsive` breakpoint utility |
| Platforms | Android · iOS · Web · Windows · macOS · Linux |

---

## Navigation & Interactivity

### Screen-by-screen interactions

**Login Screen**
- Email and password validation with error messages
- Toggle password visibility
- Loading spinner on login tap
- Forgot password dialog with email input
- Sign-up snackbar prompt
- Animated fade transition to Home

**Home Screen**
- Tap avatar → profile bottom sheet with logout
- Tap bell → notifications bottom sheet
- Tap in-progress card → navigates to Program Detail
- Tap "See all" → navigates to Program List
- Tap any program card → navigates to Program Detail with data
- Bottom navigation (Home / Explore / My Learning / Profile)

**Program Listing**
- Live search — filters as you type
- Clear button appears when search has text
- Category chips filter programs
- Result count updates dynamically
- Empty state when no results found
- Each card navigates to Program Detail

**Program Detail**
- Bookmark toggle with snackbar feedback
- Enrol button changes to "Enrolled!" after tapping
- Snackbar with "Go Home" action after enrolment
- Share button with clipboard snackbar
- Full curriculum with module list
- What you'll learn checklist

---

## Getting Started

### Prerequisites
- Flutter SDK 3.x — [flutter.dev](https://flutter.dev/docs/get-started/install)
- Chrome (for web), Android Studio (for Android)

### Run the app

```bash
# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome --release

# Run on Windows desktop
flutter run -d windows

# Run on Android
flutter run -d android
```

---

## Commit History

| Commit | Description |
|--------|-------------|
| `f0c7eae` | Initial commit: LearnHub Flutter App |
| `b4cac06` | docs: add Week 1 App Proposal and README |
| `32a31e7` | docs: add Week 1 App Proposal PDF |
| `latest` | feat: Week 2 — interactive UI prototype with full navigation |

---

## Author

**kutikantiyashwanth** — LearnHub Flutter LMS · 2026
