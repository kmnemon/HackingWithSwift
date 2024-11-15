//
//  Dice.swift
//  RollDice
//
//  Created by ke on 2024/11/15.
//

import Foundation

@Observable
class Dice: Identifiable {
    var id: UUID
    var type: Int
    var value: Int
    
    init(type: Int) {
        self.id = UUID()
        self.type = type
        self.value = type
    }
    
    func roll() {
        value = Int.random(in: 1...type)
    }
}
