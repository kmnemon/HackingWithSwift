//
//  ContentView.swift
//  iExpense
//
//  Created by Paul Hudson on 15/10/2023.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    var personItems: [ExpenseItem] {
        var pItems = [ExpenseItem]()
        for item in self.items {
            if item.type == "Personal" {
                pItems.append(item)
            }
        }
        return pItems
    }
    
    var businessItems: [ExpenseItem] {
        var bItems = [ExpenseItem]()
        for item in self.items {
            if item.type == "Business" {
                bItems.append(item)
            }
        }
        return bItems
    }
}

struct MoneyStyle: ViewModifier{
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
        
    }
}

extension View{
    func moneyStyle(at amount: Double) -> some View{
        if amount < 10 {
            modifier(MoneyStyle(color: .green))
        } else if amount < 100 {
            modifier(MoneyStyle(color: .blue))
        } else {
            modifier(MoneyStyle(color: .red))
        }
    }
    
    
}


struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.personItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .moneyStyle(at: item.amount)
                        }
                        
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section("Business") {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .moneyStyle(at: item.amount)
                        }
                        
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense(sheet)", systemImage: "plus") {
                    showingAddExpense = true
                }
                
                NavigationLink("Add Expense(link)") {
                    AddView(expenses: expenses)
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}




#Preview {
    ContentView()
}
