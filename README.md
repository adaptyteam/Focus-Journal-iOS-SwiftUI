# [Focus Journal for iOS with SwiftUI](https://github.com/ferrousguy/Focus-Journal-iOS-SwiftUI)

This repository demonstrates how to integrate the [Adapty SDK](https://adapty.io) into an existing SwiftUI-based iOS project. It contains two branches:

- **`starter`**: A “clean slate” version of the Focus Journal app with no Adapty code included. Use this branch to follow the Quickstart guide and add Adapty yourself.
- **`main`**: The fully integrated version, showing the completed Adapty integration for reference.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Branch Structure](#branch-structure)  
3. [Prerequisites](#prerequisites)
4. [Getting Started](#getting-started)   
5. [Running the Example](#running-the-example)  

---

## Project Overview

**Focus Journal** is a simple mood journal app that lets users log a daily mood entry and view their history. In the “premium” flow, tapping “History” triggers a paywall flow if the user is not subscribed. The Adapty SDK is used to:

1. **Activate Adapty at launch**  
2. **Fetch the user’s profile and determine access**  
3. **Display a customizable flow UI**  
4. **Handle purchase/restore callbacks**  

You can follow along on the `starter` branch to add Adapty manually, or inspect the `main` branch to see the final result.

---

## Branch Structure

- **`starter`**  
  - Contains the Focus Journal Xcode project without any Adapty code.  
  - Meant as a starting point for readers.  

- **`main`**  
  - Contains the same Focus Journal project, but with all Adapty integration steps already applied.  
  - Compare this branch to `starter` to see exactly which files changed and how.  

---

## Prerequisites

- **Xcode 14.0+**  
- **iOS 15.0+** target (you can adjust as needed)  
- **Swift 5**  
- A valid **Adapty account** with an SDK key (visit [app.adapty.io/settings](https://app.adapty.io/settings) to get your SDK key)  

---

## Getting Started

1. **Clone this repository**  
   ```bash
   git clone https://github.com/ferrousguy/Focus-Journal-iOS-SwiftUI.git
   cd focus-journal
   ```
   
2. **Check out the starter branch**
	```bash
	git checkout starter
	```

3. **Open the Xcode project**
	```bash
	open FocusJournal.xcodeproj
	```

4. **Follow the Quickstart Integration Guide to add Adapty step-by-step.**

5. When you're done, or if you get stuck, switch to the `main` branch to compare your work:
	```bash
	git checkout main
	```
## Running the Example

1.	git checkout main
2.	Open FocusJournal.xcodeproj.
3.	Add your Adapty API key to AppConstants.swift.
4.	Build & run and you’ll see Adapty initialize itself.

Note: You need the products, placements, and flows already defined in your Adapty dashboard. See [these docs](https://adapty.io/docs/quickstart) for help.

You should now have a working Adapty integration in a SwiftUI-based iOS app. Feel free to explore the main branch to see the complete implementation or continue customizing the UI in HomeView.swift and ProfileManager.swift.

If you find any mistakes or have questions, please open an issue or submit a pull request. Happy coding!
