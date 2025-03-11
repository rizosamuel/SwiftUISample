# 📱 SwiftUISample

SwiftUISample is a modular iOS app built using SwiftUI and follows the **Clean Architecture** pattern. It separates UI, business logic, and data layers for better maintainability and scalability.

---

## 🚀 Features

- **🏠 Home View** – Displays a list of featured items.
- **📂 Categories View** – Lists categories dynamically.
- **🛍 My Orders View** – Shows user orders.
- **👤 Account View** – Displays user profile and settings.
- **🔄 Navigation Management** – Uses a custom `RouterImpl` for screen transitions.
- **🗂 Clean Architecture** – Organizes code into `Data`, `Domain`, and `Presentation` layers.

---

## 🏗 Architecture

This project follows **Clean Architecture**, dividing responsibilities into layers:

### **Layer Responsibilities**
- **Data Layer:** Fetches data from APIs or local storage.
- **Domain Layer:** Contains business logic.
- **Presentation Layer:** Handles UI and ViewModels.

---

## 📸 Screenshots (Placeholder)

| Home View | Categories View | Account View |
|-----------|---------------|--------------|
| ![Home](screenshots/home.png) | ![Categories](screenshots/categories.png) | ![Account](screenshots/account.png) |

---

## 🛠 Installation

1. **Clone the repository**:
   git clone https://github.com/yourusername/SwiftUISample.git
   cd SwiftUISample
   
2. Open the project in Xcode:
    open SwiftUISample.xcodeproj

3. Run the project:
    Select a simulator or device in Xcode.
    Press Cmd + R to build and run.

## 📂 Project Structure

·/
│── SwiftUISample.xcodeproj      # Xcode project file
│── SwiftUISample/               # Main source code
│   ├── Data/                    # Handles API, local storage, and models
│   ├── Domain/                  # Business logic, use cases
│   ├── Presentation/             # SwiftUI Views, ViewModels
│   ├── Utilities/                # Helpers and extensions
│   ├── Resources/                # Assets, colors, fonts
│   ├── Supporting Files/         # Configurations and constants
│── README.md                    # Project documentation
│── .gitignore                    # Git ignore unnecessary files

## 📌 Usage & Navigation

·Tab Navigation:
    The app has a TabView with 4 tabs (Home, Categories, Orders, Account).
    Each tab uses a NavigationStack for deep navigation.

·Routing:
    The RouterImpl class manages navigation.
    Use router.navigate(to: .categories, switchTab: true) to switch tabs.

·Back Navigation:
    router.goBack() removes the last navigation entry.

·Reset to Root:
    router.resetToRoot(for: selectedTab)
    
## 🤝 Contributing

1. Fork the project.

2. Create a feature branch:
    git checkout -b feature-branch

3. Commit your changes:
    git commit -m "Added new feature"

4. Push to the branch:
    git push origin feature-branch

5. Open a Pull Request.

## ⚖️ License

This project is open-source and available under the MIT License.

## 📬 Contact

For any issues or suggestions, feel free to create an issue or reach out!

🎉 Happy Coding!
