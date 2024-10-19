//
//  AddActivityView.swift
//  HabitTracking
//
//  Created by ke on 10/19/24.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var activityTitle: String = ""
    @State var activityDescription: String = ""
    
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Activity Title:")
                    TextField("Activity Title", text: $activityTitle)
                }
                
                HStack {
                    Text("Activity Description:")
                    TextField("Activity Description", text: $activityDescription)
                }
            }
            
            .toolbar {
                Button("Save") {
                    let activity = Activity(id: UUID(), title: activityTitle, description: activityDescription)
                    activities.activities.append(activity)
                    dismiss()
                }
                
                Button("Cancel") {
                    dismiss()
                }
            }
            
            Spacer()
        }
    }
}
