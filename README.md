# SwiftUISample

SwiftUISample is an iOS application built using SwiftUI. It provides a tab-based navigation system with multiple sections, including Home, Categories, My Orders, and Account. The project utilizes `NavigationStack`, `TabView`, and an MVVM architecture for a clean and scalable codebase.

## Features

- **Tab-Based Navigation**: Includes Home, Categories, My Orders, and Account sections.
- **NavigationStack**: Enables deep navigation within each tab.
- **Router Implementation**: Manages navigation across different views.
- **MVVM Architecture**: Uses `ObservableObject` for state management.
- **Search Functionality**: A basic search bar in the Home view.
- **Category Listing**: Displays a list of predefined categories.
- **User Account Section**: Includes a profile picture, wishlist, cart, and settings.

## Project Structure

```
SwiftUISample/
│── SwiftUISampleApp.swift
│── Router.swift
│── Views/
│   │── DashboardView.swift
│   │── HomeView.swift
│   │── CategoriesView.swift
│   │── OrdersView.swift
│   │── AccountView.swift
│── ViewModels/
│   │── HomeViewModel.swift
│   │── CategoriesViewModel.swift
│── Models/
│── Assets.xcassets
│── README.md
```

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/SwiftUISample.git
   ```
2. Open the project in Xcode:
   ```sh
   cd SwiftUISample
   open SwiftUISample.xcodeproj
   ```
3. Build and run the app on a simulator or device.

## Usage

- **Home Tab**: Displays products and categories.
- **Categories Tab**: Shows a list of available categories.
- **My Orders Tab**: Placeholder for order history.
- **Account Tab**: Displays user information and account options.

## Git Ignore

The `.gitignore` file ensures unnecessary files are not tracked by Git. It includes:

- Derived data and build files
- Xcode workspace settings
- User-specific settings
- `.DS_Store` and other macOS system files

## Contributing

Contributions are welcome! Feel free to submit a pull request.

## License

This project is licensed under the MIT License.
