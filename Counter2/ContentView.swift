//
//  ContentView.swift
//  Counter2
//
//  Created by Viraj Chitnis on 7/21/20.
//  Copyright © 2020 Viraj Chitnis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var newTitle: String = ""
    @State private var newNote: String = ""
    @State private var newCount: String = ""
    
    @FetchRequest(
        entity: Counter.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Counter.title, ascending: true)
        ]
    ) var counters: FetchedResults<Counter>
    
    var body: some View {
        VStack {
            TextField("Title", text: $newTitle)
                .padding()
            TextField("Note", text: $newNote)
                .padding()
            TextField("Count", text: $newCount)
                .padding()
            Button(action: {
                self.addCounter(title: self.newTitle, note: self.newNote, count: self.newCount)
            }) {
                Text("Save")
            }
            Divider()
            List(counters, id: \.self) { counter in
                Text("\(counter.title ?? "")")
            }
        }
    }
    
    func addCounter(title: String, note: String, count: String) {
        let newCounter = Counter(context: self.managedObjectContext)
        newCounter.title = title
        newCounter.note = note
        if let countInt: Int64 = Int64(count) {
            newCounter.count = countInt
        }
        self.saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
