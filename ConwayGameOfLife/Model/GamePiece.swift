//
//  GamePiece.swift
//  ConwayGameOfLife
//
//  Created by Taffie Coler on 11/20/19.
//  Copyright © 2019 Taffie Coler. All rights reserved.
//

import UIKit

struct GamePiece{
    var alive: Bool
    var color: UIColor {
        return self.alive ? K.Colors.aliveColor : K.Colors.deadColor
    }
    
    init(){
        self.alive = false
    }
    
    init(alive: Bool){
        self.alive = alive
    }
    
    mutating func flipState(){
        self.alive = !self.alive
    }
}
