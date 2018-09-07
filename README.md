# iMovies

This is a project to create a simple app to search movies

## Project Architecture 
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/projectArchitecture.jpeg?raw=true)

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

## Search results
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/01.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/02.png?raw=true)

## Recent searchs
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/03.png?raw=true)

## Handling errors and states
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/04.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/05.png?raw=true)
![alt tag](https://github.com/rcasanovan/iMovies/blob/master/Images/06.png?raw=true)

## Support && contact

### Email

You can contact me using my email: ricardo.casanova@outlook.com

### Twitter

Follow me [@rcasanovan](http://twitter.com/rcasanovan) on twitter.