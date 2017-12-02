//
//  Beer.swift
//  RM30308
//
//  Created by Danielle Pereira on 02/12/17.
//  Copyright © 2017 Danielle Pereira. All rights reserved.
//

import Foundation

class Beer {
    
    var image_url: String
    var name: String
    var tagline: String //slogan
    var abv: Double //teor alcoólico (alcohol by volume)
    var ibu: Double //escala de amargor (beer measurement)
    var description: String
    var id: String
    
    init(_image_url: String, _name: String, _tagline: String, _abv: Double, _ibu: Double, _description: String, _id: String) {
        self.image_url = _image_url
        self.name = _name
        self.tagline = _tagline
        self.abv = _abv
        self.ibu = _ibu
        self.description = _description
        self.id = _id
    }
    
}

