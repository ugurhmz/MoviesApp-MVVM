


import Foundation




struct  MovieListViewModel {
    let movieList : [Result]
    
    
    func numberOfRowsInSection() -> Int {
        return self.movieList.count
    }
    
    
    func movieAtIndex(_ index: Int) -> MovieViewModel {
        let mv = self.movieList[index]
        return MovieViewModel(movie: mv)
    }
    
    
}


struct MovieViewModel {
    let movie : Result
    
    
    var title : String {
        return self.movie.title ?? "-"
    }
    
    var vote : Double {
        var myAverage:Double = 0.0
        
        if let voteAverage = self.movie.voteAverage {
            myAverage = voteAverage
        }
        
        return myAverage
    }
    
}
