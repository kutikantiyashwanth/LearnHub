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

### Learner
- Email/password login
- Personalised home dashboard with in-progress course, popular programs, and achievements
- Program listing with search and category filters
- Program detail page with lessons, duration, level, and enrolment
- Responsive layout (mobile / tablet / desktop)

### Admin *(planned for future weeks)*
- Create and manage programs
- View enrolled learner statistics
- Manage user accounts

---

## App Navigation Flow

```
/login
   └── Log In button
         └── /home  (Dashboard)
               ├── Program card tap → /program-detail
               └── Bottom nav / sidebar
                     ├── Explore → /programs
                     │     └── Program card tap → /program-detail
                     ├── My Learning (planned)
                     └── Profile (planned)
```

---

## Project Structure

```
LearnHub/
├── lib/
│   ├── main.dart                  # App entry point & route table
│   ├── screens/
│   │   ├── login_screen.dart      # Login page (desktop split + mobile)
│   │   ├── home_screen.dart       # Dashboard with progress & programs
│   │   ├── program_list_screen.dart   # Browseable program catalog
│   │   └── program_detail_screen.dart # Full program info + enrol
│   ├── theme/
│   │   └── app_theme.dart         # Colors, spacing, radii, ThemeData
│   └── utils/
│       └── responsive.dart        # Breakpoint helpers & ResponsiveCenter
├── android/                       # Android platform files
├── ios/                           # iOS platform files
├── web/                           # Web platform files
├── windows/                       # Windows desktop platform files
├── pubspec.yaml                   # Dependencies
└── README.md                      # This file
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.44 (Dart 3.12) |
| UI | Material Design 3 |
| State | StatefulWidget (local state) |
| Navigation | Named routes (`Navigator`) |
| Responsive | Custom `Responsive` breakpoint utility |
| Platforms | Android · iOS · Web · Windows · macOS · Linux |

---

## Getting Started

### Prerequisites
- Flutter SDK 3.x — [flutter.dev](https://flutter.dev/docs/get-started/install)
- Chrome (for web), Android Studio (for Android), or Xcode (for iOS)

### Run the app

```bash
# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Run on Windows desktop
flutter run -d windows

# Run on Android
flutter run -d android
```

---

## Version Control

This repository uses Git for version control. All source code is committed and pushed to GitHub with meaningful commit messages tracking each development milestone.

---

## Author

**LearnHub** — Week 1 Submission  
Flutter LMS Project · 2026
