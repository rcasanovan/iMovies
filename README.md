# iMovies

This is a project to create a simple app to search movies

## 🚨 Important note 🚨

This project is using cocoapods but a gitignore file is there so the third-party libraries are not part of the repo. Please be sure to run the **pod install** command before running the project.

If you have any doubt about cocoapods you can check the reference [here](https://cocoapods.org).

To run the project you just need to add your API key in EndPoint swift file

```swift
static let apiKey: String = "ADD YOUR API KEY HERE"
```

## Project Architecture 
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/projectArchitecture.jpeg?raw=true)

References:
* [Viper architecture](https://www.objc.io/issues/13-architecture/viper/)
* [Viper for iOS](https://medium.com/@smalam119/viper-design-pattern-for-ios-application-development-7a9703902af6)

## How did I implement VIPER?

Basically I have a protocol file for each scene in the app. This file defines the interaction between each layer as following:

* View - Presenter: protocols to notify changes and to inject information to the UI.
* Presenter - Interactor: protocols to request / receive information to / from the interator.
* Presenter - Router: protocol to define the transitions between scenes (I skiped this protocols for the demo because I have only a scene there).

Whith this protocols file is really easy to know how each layer notify / request / information to the other ones so we don't have any other way to communicate all the layers.

Another important point is because I'm using protocols it's really easy to define mocks views / presenters / interactors / routers for testing.

```swift
// View / Presenter
protocol IMSearchViewInjection : class {
    func loadMovies(_ movies: [IMMovieViewModel], fromBeginning: Bool, totalResults: UInt)
    func loadSuggestions(_ suggestions: [IMSuggestionViewModel])
    func showProgress(_ show: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol IMSearchPresenterDelegate : class {
    func searchMovie(_ movie: String)
    func loadNextPage()
    func getSuggestions()
    func suggestionSelectedAt(index: NSInteger)
}

// Presenter / Interactor

typealias IMGetMoviesCompletionBlock = (Result<IMMoviesResponse?>) -> Void
typealias IMGetSuggestionsCompletionBlock = ([IMSuggestionViewModel]) -> Void

protocol IMSearchInteractorDelegate : class {
    func shouldGetMovies() -> Bool
    func clearSearch()
    func getMoviesWith(movie: String, completion: @escaping IMGetMoviesCompletionBlock)
    func saveSearch(_ search: String)
    func getAllSuggestions(completion: @escaping IMGetSuggestionsCompletionBlock)
    func updateResultResponse(_ response: IMMoviesResponse?)
}
```

## Use cases

1. As​ ​a​ ​user​ ​at​ ​the​ ​search​ ​screen, when​ ​I​ ​enter​ ​a​ ​name​ ​of​ ​a​ ​movie​ ​(e.g.​ ​"Batman",​ ​"Rocky")​ ​in​ ​the​ ​search​ ​box​ ​and tap​ ​on​ ​"search​ ​button" then​ ​I​ ​should​ ​see​ ​a​ ​new​ ​list​ ​view​ ​with​ ​the​ ​following​ ​rows:
* Movie​ ​Poster
* Movie​ ​name
* Release​ ​date
* Full​ ​Movie​ ​Overview

2. As​ ​a​ ​user​ ​at​ ​the​ ​Movie​ ​List​ ​Screen, when​ ​I​ ​scroll​ ​to​ ​the​ ​bottom​ ​of​ ​list then​ ​next​ ​page​ ​should​ ​load​ ​if​ ​available

3. As​ ​a​ ​user​ ​at​ ​the​ ​search​ ​screen, when​ ​I​ ​enter​ ​a​ ​name​ ​of​ ​a​ ​movie​ ​that​ ​doesn’t​ ​exist​ ​in​ ​the​ ​search​ ​box​ ​and​ ​tap​ ​on "search​ ​button", then,​ ​an​ ​alert​ ​box​ ​should​ ​appear​ ​and​ ​display​ ​an​ ​error​ ​message.

All​ ​types​ ​of​ ​error​ ​should​ ​be​ ​handled

4. As​ ​a​ ​user​ ​at​ ​the​ ​search​ ​screen, when​ ​I​ ​tap​ ​and​ ​focus​ ​into​ ​the​ ​search​ ​box then​ ​an​ ​auto​ ​suggest​ ​list​ ​view​ ​will​ ​display​ ​below​ ​the​ ​search​ ​box​ ​showing​ my​ ​last 10​ ​successful​ ​queries​ ​(exclude​ ​suggestions​ ​that​ ​return​ ​errors)

Suggestions​ ​should​ ​be​ ​persisted.

5. As​ ​a​ ​user​ ​at​ ​the​ ​search​ ​screen​ ​with​ ​the​ ​auto​ ​suggest​ ​list​ ​view​ ​shown, when​ ​I​ ​select​ ​a​ ​suggestion then​ ​the​ ​search​ ​results​ ​of​ ​the​ ​suggestion​ ​will​ ​be​ ​shown.

## First at all. Where is the data came from?

I'm using the api from **themoviedb.org** (you can check the api documentation [here](https://www.themoviedb.org/documentation/api)).

You just need to create an account to have access to the api. Once you do it you'll able to get information for movies in a JSON format like this:

```json
{
  "page": 1,
  "total_results": 102,
  "total_pages": 6,
  "results": [
    {
      "vote_count": 3107,
      "id": 268,
      "video": false,
      "vote_average": 7.1,
      "title": "Batman",
      "popularity": 15.817,
      "poster_path": "/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg",
      "original_language": "en",
      "original_title": "Batman",
      "genre_ids": [
        14,
        28
      ],
      "backdrop_path": "/2blmxp2pr4BhwQr74AdCfwgfMOb.jpg",
      "adult": false,
      "overview": "The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker, who has seized control of Gotham's underworld.",
      "release_date": "1989-06-23"
    }
    ]
}
```

This is an example of the api call:
http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=1

In order to get the images you can use this url:
http://image.tmdb.org/t/p/w92/2DtPSyODKWXluIRV7PVru0SSzja.jpg​

(Poster size: size:​ ​w92,​ ​w185,​ ​w500, w780)

## Data models

### Network data models

These includes the following models:

```swift
struct IMMoviesResponse: Decodable {
    let page: UInt
    let total_results: UInt
    let total_pages: UInt
    let results: [IMSingleMovieResponse]
}

struct IMSingleMovieResponse: Decodable {
    let id: UInt
    let vote_average: Float
    let poster_path: String?
    let title: String
    let overview: String?
    let release_date: String
}
```

I'm using a Swift Standard Library decodable functionality in order to manage a type that can decode itself from an external representation (I really ❤ this from Swift).

**Why some properties are optionals?**

Well I discovered that some movies doesn't have a poster path or an overview (it's strange I know 🤷‍♂) so it's better to manage these fields are optionals.

**Are more properties there??**

Obviously the response has more properties for each movie. I decided to use only these ones.

Reference: [Apple documentation](https://developer.apple.com/documentation/swift/swift_standard_library/encoding_decoding_and_serialization)


### Suggestions data model

This model is used for the movies suggestions (last 10​ ​successful​ ​queries​ - exclude​ ​suggestions​ ​that​ ​return​ ​errors)

```swift
class IMSearchSuggestion: Object {
    @objc dynamic var suggestionId: String?
    @objc dynamic var suggestion: String = ""
    @objc dynamic var timestamp: TimeInterval = NSDate().timeIntervalSince1970
    
    override class func primaryKey() -> String? {
        return "suggestionId"
    }
}
```

As I'm using Realm for this it's important to define a class to manage each model in the database. In this case we only have one model (IMSearchSuggestion)

Reference: [Realm](https://realm.io/docs/swift/latest)

### Managers

I think using managers is a good idea but be careful!. Please don't create managers as if the world were going to end tomorrow.

I'm using only 3 here:

#### IMSearchSuggestionsManager

Used to manage all the suggestions (last 10​ ​successful​ ​queries​)

#### IMMovieImageManager

Used to manage the images (create the urls to retrieve the images)


#### IMNetworkManager

Used to manage the reachability

## How it looks like?

### Search results
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/01.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/07.png?raw=true)

### Recent searchs
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/03.png?raw=true)

### Handling errors and states
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/04.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/05.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/06.png?raw=true)

## What's left in the demo?

* Realm migration process: It would be nice to add a process to migrate the realm database to a new model (just in case you need to add a new field into the database)
* Localizable files: This demo doesn't include the localizable files to translate the app to different languages.


## Programming languages && Development tools

* Swift 4.1
* Xcode 9.4.1
* [Cocoapods](https://cocoapods.org) 1.5.3
* Minimun iOS version: 9.0

## Third-Party Libraries

* [Haneke](https://github.com/Haneke/Haneke) (1.0): A lightweight zero-config image cache for iOS
* [EDStarRating](https://github.com/erndev/EDStarRating) (1.1): A configurable star rating control for OSX and iOS, similar to those found in iTunes and the App Store.
* [RealmSwift](https://github.com/realm/realm-cocoa) (3.7.6): A mobile database that runs directly inside phones, tablets or wearables
* [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) (2.2.5): A clean and lightweight progress HUD for your iOS and tvOS app.
* [ReachabilitySwift](https://github.com/ashleymills/Reachability.swift) (4.2.1): Replacement for Apple's Reachability re-written in Swift with callbacks.

## Support && contact

### Email

You can contact me using my email: ricardo.casanova@outlook.com

### Twitter

Follow me [@rcasanovan](http://twitter.com/rcasanovan) on twitter.