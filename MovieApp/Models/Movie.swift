//
//  Movie.swift
//  MovieApp
//
//  Created by Anup Saud on 2024-09-09.
//

import Foundation
struct MovieResoponse: Decodable{
    let Search: [Movie]
    
}

struct Movie:Decodable {
    
    let title: String
    let year: String
    
    private enum CodingKeys: String, CodingKey{
        
        case title = "Title"
        case year = "Year"
    }
}
