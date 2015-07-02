
//
//  Project.swift
//  Crumful-Mil
//
//  Created by Marvin Allan Lu on 7/1/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import Foundation

class Project {
    var name:String
    var id:Int
    
    init(id:Int, name:String) {
        self.id = id
        self.name = name
    }
    
    func toJSON() -> String {
        return "{beast: 'mode'}"
    }
}
