# PopularMovies App Example
[![Swift Version][swift-image]][swift-url]


This iOS app (Swift) was developed as a Technical Assignment as part of the recruitment process for the **iOS developer** role.

The App allows to get Playing-Now and Popular movie lists using the [TheMovieDB API](https://api.themoviedb.org).


![Movie List](/readmePics/movieList.PNG)
![Movie Details](/readmePics/movieDetails.PNG)

## Version

1.0


## Requirements

* Xcode 11.5 or later
* iOS 13.0 or later


## Build and Run App

1. Clone this repo
1. Open `PopularMovies.xcodeproj` and run the project on selected device or simulator


## 3rd Party Libraries

* [CocoaLumberjack/Swift](https://github.com/CocoaLumberjack/CocoaLumberjack.git) **Swift Package Manager** dependency - logging framework
* [Reachability](https://github.com/ashleymills/Reachability.swift) source file  - checking of network interface reachability


## App Features Implementation

Project architecture **MVVM**


### 1. Image caching

* Using ImageLoadingService class to receive image data from imageCache or to get image data by REST request and save to imageCache.

* Using UIImgeView Extension to setup Image by imagePath. There is functionality to setup the placeholder image in case the image data is not available.


### 2. Rating custom progress bar

The custom **RatingView** has been created by using **CAShapeLayer** class of **Core Animation** Framework.


### 3. Movie details fetching

According to the **Instrucrtions for the assingment**, each of list item on the first screen should contain the Movie Duration info.
But the API endpoint [/movie/popular](https://developers.themoviedb.org/3/movies/get-popular-movies) does not return information about the movie duration  ("runtime").
Therefore, it was necessary to implement two REST requests synchronously:

1. Get list ID of popular movies: GET [/movie/popular](https://developers.themoviedb.org/3/movies/get-popular-movies)
1. Asynchronously get movie details for each movie ID: GET [/movie/{movie_id}](https://developers.themoviedb.org/3/movies/get-movie-details)

This process has been implemented using **OperationQueue** and **Operations**.  

The custom class **AsyncOperation** has been created to tracking the operation state.

The custom wrapper class **MovieArrayWrapper** has been created to pass safely movie details array between threads.


### 4. Genres list representation

The Genres list representation has been implemented by putting an attributed text to TextView.

The logic of custom **GenresTextBuilder** class:

1. Convert Strings to Labels
1. Convert Labels to Images
1. Convert Images to attributed text


## Meta

Włodzimierz Woźniak

[w.wozniak@vivatum.com](mailto:w.wozniak@vivatum.com)

[vivatum.com](http://vivatum.com)



[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
