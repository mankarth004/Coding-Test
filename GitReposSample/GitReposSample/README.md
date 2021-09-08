# Coding Test - Git Repository Search

The intension of this coding test is to fetch the git repository from the REST API using a query string.

## Environment
    1. This app runs on iOS devices like iPod, iPhone and iPad
    2. Application is developed using Swift(v-5) language using Xcode(v-12.4) IDE
    3. Deployment target is iOS 11.0

## Architecture
    Used MVVM architecture for neat, modular and testable code

## Code coverage
    Integrated Unit testing with 90% code coverage

## Dependencies and sources
    1. Thanks to GitHub Search API providing great APIs. In this application I used (https://developer.github.com/v3/search).
    2. Making the use of (https://github.com/Alamofire/Alamofire) for network calls.
    3. Using SDWebImage (https://github.com/SDWebImage/SDWebImage) for image loading and caching.

## Implementation
### UI Preparation
    1. Programmatically creating the UI
    2. Using Autolayouts to prepare the UI

### Structure
Contains 2 main folders in the target

    1. Application
        a. Resources - Assets, LaunchScreen.storyboard and plist
        b. Utilities - Constants, Extensions, Validators & Dataproviders
        c. AppDelegate & SceneDelegate
    2. MVVM
        a. Models - RepoSearchResult.swift - To hold data 
        b. Views - RepoTableViewCell.swift - For rendering data
        c. Controllers - ViewController.swift - To hold views
        d. ViewModels - RepoSearchResultViewModel.swift - Logic Implementation
    
### Functionality
    1. Search
        a. Validation - Length validaiton(min 4 & max 30), alphanumeric & certain special characters allowed.
    2. Fetch - Once the validation is done using the GitHub search API to fetch repositories using a query, page size is 20.
    3. Pagination - If the user scrolls down to the bottom, make another request to get second page data and add them to previous records and show.
    4. View Detail - Clicking on the repo should navigate to the repository website to view full details.
