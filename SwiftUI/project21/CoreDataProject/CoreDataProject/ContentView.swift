//
//  ContentView.swift
//  CoreDataProject
//
//  Created by ke on 11/14/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var movies: FetchedResults<Movie>
    
    var body: some View {
        VStack {
            List(movies, id: \.self) { movie in
                Text(movie.title ?? "Unknown")
            }
        }
        
        Button("Add") {
            let movie = Movie(context: moc)
            movie.title = "Harry Potter"
        }
        
        
        Button("Save") {
            // moc save before check there is a change
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
