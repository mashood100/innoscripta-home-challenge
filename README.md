# Innoscripta Task Timer  

A Flutter application for efficient task management with advanced time-tracking capabilities. This app empowers users to create, manage, and track tasks across multiple projects with features designed for productivity and collaboration.  

## Features  

- ⏱️ **Task Time Tracking**: Start, pause, and reset functionality for each task.  
- 📂 **Multiple Projects**: Organize tasks across different projects effortlessly.  
- 🗂️ **Kanban Boards**: Manage tasks across *To-Do*, *In Progress*, and *Completed* boards.  
- 🎯 **Drag and Drop**: Seamlessly move tasks between different boards.  
- 💬 **Task Comments**: Add and review comments for each task.  
- 📅 **Dates and Deadlines**: Assign due dates to tasks for better planning.  

## Bonus Features  

- 🌐 **Multi-Language Support**: A localized experience for diverse users.  
- 📊 **Firebase Analytics**: Track production issues and monitor app performance.  
- 🌗 **Dark and Light Themes**: Adapt to your preferred visual style.  

## Architecture  

The app follows **Clean Architecture** principles:  
- **Data Layer**: Handles APIs, databases, and repositories.  
- **Domain Layer**: Manages core business logic and use cases.  
- **Presentation Layer**: Provides UI and state management.  

**Development Approach**:  
- Test-driven development (TDD) for high-quality, maintainable code.  

## Getting Started  

### Prerequisites  

Ensure the following are installed:  
- Flutter SDK (3.0.0 or higher)  
- Dart SDK (2.17.0 or higher)  
- Android Studio or VS Code with Flutter extensions  
- An Android or iOS device/emulator  

### Installation  

1. Clone the repository:  

   ```bash
   git clone https://github.com/your-username/innoscripta_home_challenge.git

2. Navigate to the project directory:

```bash
cd innoscripta_home_challenge
```
3. Install dependencies:

```bash
flutter clean  
flutter pub get
```

4.Run the app:

```bash
flutter run
```
### CI/CD  

You can download the latest build directly from the GitHub Actions workflow artifacts.  

1. Navigate to the **Actions** tab in the repository.  
2. Select the latest successful workflow run.  
3. Scroll down to the **Artifacts** section.  
4. Download the relevant build file (e.g., `app-release.apk` for Android).  
[View latest builds](https://github.com/mashood100/innoscripta-home-challenge/actions/)
<img width="1437" alt="Screenshot 2024-11-19 at 2 17 29 AM" src="https://github.com/user-attachments/assets/b7dbdb31-0d45-473a-94e7-5c443f3a6532">

## Clean Code Architecture  
<img width="1100" alt="arch_1" src="https://github.com/user-attachments/assets/a480a8c8-a2ba-4314-80c3-1ba3f8903543">

The project follows a clean architecture pattern, ensuring clear separation of concerns and maintainable code. Below is an overview of the structure:  


### Data Layer  
  
- **DTO**: Data Transfer Objects for transforming data between the API and the domain layer. Defines how data is serialized and deserialized.  
- **Repository**: Provides concrete implementations of repository interfaces, handling data operations and connecting the app to the data layer.  
- **Source**: Implements data sources ( network or local storage) to manage data retrieval mechanisms.  

### Domain Layer  

- **Entity**: Contains core business objects and models that define the application's data structures. These objects are independent of the data layer.  
- **Repository**: Defines abstract interfaces for data operations, creating contracts for the data layer to follow.  
- **Use Cases**: Encapsulates business logic and orchestrates data flow between repositories and the UI, implementing the core functionality of the app.  

### Presentation Layer  

- **Provider**: Manages application state using Riverpod providers to handle state and business logic for the UI.  
- **Routes**: Defines the navigation structure and handles app routing.  
- **Screens**: Contains the visual components and widgets for the app's user interface.  
- **Shared**: Houses reusable widgets and components shared across different screens.  
- **Theme**: Manages the app’s theme, including colors, text styles, and other visual elements.  

### Core Layer  

- **Configs**: Contains application-wide configuration settings like API endpoints, environment variables, and language configurations. This folder sets up the foundation of the app.  
- **Packages**: Manages and initializes external packages, serving as a central hub for third-party integrations.  
- **Utils**: Includes utility functions and helper methods, such as date formatting or color manipulation, used throughout the app.  

### Testing  

- **Test**: Organizes test files by layer (data, domain, and presentation) to ensure thorough coverage.  
- **Fixtures**: Provides mock data and test fixtures for consistent testing scenarios.  

---

This structure follows clean architecture and SOLID principles, keeping dependencies flowing from outer layers (presentation, data) toward the core domain layer. It ensures a scalable, testable, and maintainable codebase.  
### Dev Folder Structure   
<img width="271" alt="Screenshot 2024-11-19 at 2 37 22 AM" src="https://github.com/user-attachments/assets/1f01b8cb-cb64-4623-9ff7-04aa9a7fd330">

### Test Folder Structure   
<img width="271" alt="Screenshot 2024-11-19 at 2 39 53 AM" src="https://github.com/user-attachments/assets/8026593a-f44a-4af2-9383-612b45961483">
