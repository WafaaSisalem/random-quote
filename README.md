# Quoty for Today app

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Screenshots](#screenshots)
6. [Contributing](#contributing)
7. [License](#license)
8. [Contact](#contact)

## Overview

> **Quoty for Today** is a simple app built using Flutter, designed to help use generate a random quote for today.

## Features
- Get a random quote for today
- Translate your quote to Arabic
- Set a background for your quote 
- Save your favorite quotes
- Share your quote to others

## Installation

To run this project locally, follow these steps:

1. Open your command prompt and clone the repository:
   ```bash
   git clone https://github.com/WafaaSisalem/random-quote.git
2. Open the project folder and run the following command to install dependencies:
   ```bash
   flutter pub get
3. Since we're using Riverpod Code Generation run this command in the terminal to generate the files:
   ```bash
   dart run build_runner build
4. You will encounter an error in the `api_helper.dart` file. This is because the app uses two APIs:

   - **Unsplash API**: To fetch random pictures.
   - **Gemini API**: To translate the quotes.
   
   You need to set your own API keys by following these steps:
   
   1. Create a new Dart file named `my_keys.dart` in the `lib` folder.
   2. Add the following code to the file, replacing the placeholders with your actual API keys:
      ```dart
      const apiKey = 'your gemini api key';
      const unsplashKey = 'your unsplash api key';
5. Where to get these keys?
   - **Gemini API Key**: Refer to the [Gemini API Documentation](https://ai.google.dev/gemini-api/docs/api-key).
   - **Unsplash API Key**: Follow the steps in the [Unsplash API Documentation](https://unsplash.com/documentation).
   
   If you find it hard to get the API keys, feel free to contact me, and I’ll help you out.
   
   Once you've added your API keys, connect your device or emulator and run the app:
   
   ```bash
   flutter run

