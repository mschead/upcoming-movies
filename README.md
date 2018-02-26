# Upcoming Movies Challenge

### Development Purpose

* Simple iOS App, that you can check a list of incoming movies and their details.
* Built to try an iOS Developer Position.

### Instructions

1. This project uses CocoaPods to manage the project dependencies. Access https://cocoapods.org/ and follow
the install part, only. The remaining parts will be explained better here.

2. Clone this repository.

3. Access the project folder through the terminal, where you can find the _Podfile_.

4. Type the command **pod update** and wait some seconds until the dependencies get installed.

5. Then, to import the project in Xcode, you must open the file **articles-app.xcworkspace**, to allow Cocoapods manage the dependencies.

### Third-party Libraries

1. ReSwift: It's a flux implementation, the architecture that has become popular with the stack React + Redux. Through this library, it's possible to manage the application using the state concept. Although being a simple project, this pattern allows to scale the application to a more complex one. Only two actions were created:

* SetMovieDetail: when the user gets in the detail screen, it sets all the movies values in a variable that holds the current movie, such as name and overview.
* SetSearchBarText: when the some text is typed in, the current text in search bar filter is refreshed. This funcionality is not available, but I've made the management state of it, to show how simple would be to track this text change, and finish the search bar.

2. MagicalRecord: it's a way to simplify the CoreData configuration. All the context used to save and read data is managed by this library, which makes easier to have a better application database code. 
