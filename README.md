# todoapp

This is a Flutter application that uses Provider for state management, Firebase for authentication and storage, and sqflite for local storage.

# Features
- **Authentication:** Users can sign up, log in, and manage their authentication state using Firebase Authentication.

- **Data Storage:** Store user data in Firebase Firestore and manage local data with sqflite.

- **State Management:** Utilize Provider for efficient state management throughout the app.

- **Local Storage**: Use sqflite to handle local storage for offline access and caching.

# Installation
1. **Clone the repository:**
   git clone https://github.com/khanoor/todo-application.git
   
3.**Install dependencies:**
   ```flutter pub get```
   
4.**Set up Firebase:**
   - Follow the instructions to set up Firebase for both iOS and Android as described in the [Firebase documentation](https://firebase.google.com/docs/flutter/setup?platform=android).
   - Add your google-services.json (for Android) and GoogleService-Info.plist (for iOS) to the respective directories.
  
5. **Set up sqflite:**
   - Ensure you have the sqflite package added to your ```pubspec.yaml```

6. **Run the app:**
   - ```flutter run```
  
# Usage
- Authentication: Use Firebase Authentication to handle user sign-up, sign-in, and authentication state.
- Firebase Firestore: Manage data storage and retrieval using Firebase Firestore.
- Local Storage: Use sqflite for local database operations.

