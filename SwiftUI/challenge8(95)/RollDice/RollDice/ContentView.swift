//
//  ContentView.swift
//  RollDice
//
//  Created by ke on 11/15/24.
//

import SwiftUI

struct ContentView: View {
    var dices: [Dice] = [Dice(type: 4), Dice(type: 6), Dice(type: 8), Dice(type: 10), Dice(type: 12), Dice(type: 20), Dice(type: 100)]
    
    @State private var dicesForRoll: [Dice] = []
    
    @State private var showingAlert: Bool = false
    
    let layout = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    var total: Int {
        var t = 0
        for dice in dicesForRoll {
            t += dice.value
        }
        
        return t
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: layout) {
                    ForEach(dicesForRoll) { dice in
                        Button {
                            dicesForRoll.removeAll(where: { $0.id == dice.id })
                        } label: {
                            DiceView(dice: dice, size: "Big")
                        }
                    }
                }
                
                
                Spacer()
                
                Text("Total: \(total)")
                
                HStack {
                    ForEach(dices) { dice in
                        Button {
                            if dicesForRoll.count < 8 {
                                dicesForRoll.append(Dice(type: dice.type))
                            } else {
                                showingAlert = true
                            }
                        } label: {
                            DiceView(dice: dice)
                        }
                        .alert("The Max number of Dices are 8", isPresented: $showingAlert) {
                            Button("OK") {}
                        }
                    }
                    
                }
                
                Button("Roll"){
                    for dice in dicesForRoll {
                        dice.roll()
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
            }
            .navigationTitle("Roll Dice Game")
        }
    }
}

#Preview {
    ContentView()
}
