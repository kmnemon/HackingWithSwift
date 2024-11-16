//
//  ContentView.swift
//  RollDice
//
//  Created by ke on 11/15/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    var dices: [Dice] = [Dice(type: 4), Dice(type: 6), Dice(type: 8), Dice(type: 10), Dice(type: 12), Dice(type: 20), Dice(type: 100)]
    private let saveKey = "Dices"
    
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
    
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var count = 0
        
    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: layout) {
                    ForEach(dicesForRoll) { dice in
                        Button {
                            dicesForRoll.removeAll(where: { $0.id == dice.id })
                            save()
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
                                save()
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
                    timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
                    count = 5
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .sensoryFeedback(.increase, trigger: 0)
                
            }
            .navigationTitle("Roll Dice Game")
        }
        .onAppear() {
            if let data = UserDefaults.standard.data(forKey: saveKey) {
                let decoder = JSONDecoder()
                
                if let savedDices = try? decoder.decode([Dice].self, from: data) {
                    dicesForRoll = savedDices
                }
                
            }
        }
        .onReceive(timer) { _ in
            if count > 0 {
                roll()
                count -= 1
            } else if count == 0 {
                cancelTimer()
            }
        }
    }
    
    func roll() {
        for dice in dicesForRoll {
            dice.roll()
        }
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(dicesForRoll) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
    
    
    func cancelTimer() {
        timer.upstream.connect().cancel()
    }
}

#Preview {
    ContentView()
}
