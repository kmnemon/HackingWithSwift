//
//  PickDiceView.swift
//  RollDice
//
//  Created by ke on 2024/11/15.
//

import SwiftUI

struct DiceView: View {
    var dice: Dice
    var size: String = "small"
    
    var color: Color {
        switch dice.type {
            case 4: return .red
            case 6: return .blue
            case 8: return .green
            case 10: return .yellow
            case 12: return .purple
            case 20: return .orange
            default: return .black
        }
    }
    
    var sideLength: Double {
        if size == "small" {
            return Double(40)
        } else {
            return Double(120)
        }
    }
    
    var fontSzie: Font {
        if size == "small" {
            return .body
        } else {
            return .largeTitle
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(color, lineWidth: 1)
                .frame(width: sideLength, height: sideLength)
            
            Text("\(dice.value)")
                .foregroundStyle(color)
                .font(fontSzie)
        }
    }
}
