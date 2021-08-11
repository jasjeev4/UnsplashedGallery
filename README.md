# UnsplashedGallery

This project displays images from Unsplashed using the API. The app supports voice search.
For results where the API does have description for an image the app displays "Unspecified" as the description.

## Running the project

1. For best results try to run the project in the supported environment specified at the end of the README

2. Clone the repository

3. Open the project's "UnsplashedGallery.xcodeproj" file in Xcode

4. At this point Xcode should begin fetching the Swift packages the project depends on.

5. If required update the development team in Xcode: targets -> UnsplashedGallery -> Signing&Capabilities -> Team

5. Now run the project on a device or simulator (iPhone X preferred).

## File Structure

The directories in the App and their functions are:

- API - The Unsplashed client ID required for making API calls is stored here. In a production application this directory can be added to .gitignore

- Views - The app's SwiftUI views are located in this directory and organized into the two possible primary views: • Home - for the home screen • Sheet - for the popup modal

- Models - The app's model is located here

- ViewModel - The app's viewmodel is located here 

- Helpers - Contains files for • extension to Swift's string • a helper for speech recognition

## Architecture

The app has been designed with the Model View View Model architecture in mind. Model View View Model (MVVM) is a preferred architecture for SwiftUI applications.  With MVVM, the model stays lightweight and the viewmodel does the heavy lifting. The viewModel exposes an ObservableObject with Published properties which when updated update the contents of the view. The advange of doing so means there is a single source of truth for the data and the code is easier to test. 

The Model is a simple structure of the data returned by the UnsplashedAPI

There are a number of SwiftUI View's which are composed together.

The Views have minimum logic and use the ViewModel to take actions on the app's. underyling data.

## Requirements

- iOS 14.0+
- Xcode 12.5.1

## Supported Environment

- iOS 14.7.1
- Xcode 12.5.1

## Dependencies

- SwiftyJSON - To handle JSON returned by the Unsplashed API

- URLImage - To lazy load the images

- PopupView - For the Speech input popup

## Notes

- The Unsplashed API key is being included in this repository. This is done to ease testing. Typically, the API key file would be excluded from the Git repository with the .gitignore file.
