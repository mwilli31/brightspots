# brightspots

## Getting Started

Make sure you have the latest Xcode installed.  Also, we use CocoaPods for dependency management.  If you have not used that before, make sure to read the documentation on https://cocoapods.org/.

1. git clone
2. pod install
3. Make sure to open the project using the workspace file and not .project
4. Build and run

Swift 4 is currently being used

## Testing

Coming soon, we want to make sure we have tests to validate everything

## Further Info for Developers

### Pull Requests...Always

When you do any work, make sure to open a pull request.  Use branching and frequently rebase that branch to get the latest from the master branch.  If you do not open a pull request, the admin (Michael Williams) will revert the code you committed to master. You have been warned ;) 

### When to branch and how

Make sure to open a new branch for each story (task on trello - working on building this out) that you work on.  Once the pull request has been merged into the master branch, then the branch will be deleted for that story.  Thus, make sure to use a new branch for each task so that code is not accidentally lost after merge.

### MVC -> working on MVVC with time

We follow the MVC pattern in most of the code.  If you want to, you may migrate code from any Controller to a View that has to do with View logic.  However, please make sure to keep the Controller & View seperation if the abstraction has already been set up.

### Variable names

Please follow Apple's guidelines and use descriptive variable names.

### Backend APIs

We are standing on the great work of the predecessors in the Nightscout project.  All API's, models, etc. that are associated to Nightscout are captured in their own folders for clear deliniation of the work the group built!

Currently working on finding a way to integrate Karte APIs into Brightspots, coming soon!

