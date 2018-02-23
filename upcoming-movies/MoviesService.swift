//
//  MoviesService.swift
//  upcoming-movies
//
//  Created by Marcos Schead on 22/02/18.
//  Copyright © 2018 Marcos Schead. All rights reserved.
//

import Foundation

class MoviesService {
    
    func getMovies() -> [Movie] {
        var movies: [Movie] = []
        
        let movie1 = Movie()
        movie1.name = "The First Movie"
        movie1.genre = "Action"
        movie1.overview = "Nick Fury is the director of S.H.I.E.L.D., an international peace-keeping agency. The agency is a who's who of Marvel Super Heroes, with Iron Man, The Incredible Hulk, Thor, Captain America, Hawkeye and Black Widow. When global security is threatened by Loki and his cohorts, Nick Fury and his team will need all their powers to save the world from disaster which is formed by Loki and his team."
        movie1.releaseDate = "20/05/2012"
        movie1.urlImage = "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"
        
        movies.append(movie1)
        
        let movie2 = Movie()
        movie2.name = "The Second Movie"
        movie2.genre = "Action"
        movie2.overview = "Nick Fury is the director of S.H.I.E.L.D., an international peace-keeping agency. The agency is a who's who of Marvel Super Heroes, with Iron Man, The Incredible Hulk, Thor, Captain America, Hawkeye and Black Widow. When global security is threatened by Loki and his cohorts, Nick Fury and his team will need all their powers to save the world from disaster which is formed by Loki and his team."
        movie2.releaseDate = "20/05/2012"
        movie2.urlImage = "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"
        
        movies.append(movie2)
        
        return movies
    }
    
}
