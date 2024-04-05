# Login & Registration App

This Flutter project consists of multiple files for implementing a login and registration system using SQLite database. Here's a brief overview of each file and its purpose:

## `lib/main.dart`

This file serves as the entry point for the Flutter application. It defines the `MyApp` widget, which is the root widget of the application. The `MaterialApp` widget is used to define the app's theme, initial route, and routes for different pages.

## `lib/home_page.dart`

This file contains the `HomePage` widget, which represents the home page of the application. It displays a welcome message along with the username of the logged-in user.

## `lib/login_page.dart`

The `LoginPage` widget is defined in this file, which provides a user interface for logging in. It includes text fields for entering the username and password, and an option to navigate to the registration page for new users.

## `lib/registration_page.dart`

This file contains the `RegistrationPage` widget, which allows users to register by providing a username and password.

## Database Operations

### Database Initialization

The SQLite database is initialized in both the login and registration pages using the `openDatabase` function. The database schema includes a `users` table with columns for `id`, `username`, and `password`.

### Login Logic

In the login page, the `_performLogin` method is called when the login button is pressed. This method fetches the username and password from the text fields, queries the database to check if the user exists, and navigates to the home page if the login is successful.

### Registration Logic

The registration page includes a `_registerUser` method that is triggered when the register button is pressed. This method inserts a new user into the database with the provided username and password.

## Dependency Management

This project utilizes the `sqflite` package for SQLite database operations and the `path` package for file path manipulation. Both dependencies are managed using Dart's package manager, `pub`.

## Running the Application

To run the application locally, ensure that you have Flutter installed on your machine. Clone the repository, navigate to the project directory, and execute the following command:

```bash
flutter run
