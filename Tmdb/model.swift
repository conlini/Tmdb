//
//  model.swift
//  Tmdb
//
//  Created by adbhasin on 07/11/17.
//  Copyright © 2017 conlini. All rights reserved.
//

import Foundation



struct Movie: Decodable {
    
    
    let title : String
    let poster_path: String
    let overview: String
    let id: Int
    let vote_average: Float
    let release_date: String
    
    
}

struct Result: Decodable {
    
    let results : [Movie]
    
}
