source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

#link_with 'iMovies', 'iMoviesTests'


def iMoviesPods
    #Images
    pod 'Haneke', '~> 1.0'
    
    #Rating (stars)
    pod 'EDStarRating', '~> 1.1'
    
    #Realm (data base)
    pod 'RealmSwift', '~> 3.7.6'
    
    #Loader
    pod 'SVProgressHUD', '~> 2.2.5'
    
    #Networking
    pod 'ReachabilitySwift', '~> 4.2.1'
    
end

target 'iMovies' do
    iMoviesPods
end

target 'iMoviesTests' do
    iMoviesPods
end
