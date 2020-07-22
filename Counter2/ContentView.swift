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
    @State private var showAddPopover: Bool = false
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
            HStack {
                Button(action: {
                    self.showAddPopover = true
                }) {
                    Text("Add Counter")
                }
                .padding(.all)
                .popover(isPresented: self.$showAddPopover) {
                    VStack {
                        HStack {
                            Button(action: {
                                self.showAddPopover = false
                                self.resetPopoverFields()
                            }) {
                                Text("Cancel")
                            }
                            .padding(.all)
                            Spacer()
                            Button(action: {
                                self.addCounter(title: self.newTitle, note: self.newNote, count: self.newCount)
                                self.showAddPopover = false
                                self.resetPopoverFields()
                            }) {
                                Text("Save")
                            }
                            .padding(.all)
                        }
                        Divider()
                        TextField("Title", text: self.$newTitle)
                            .padding()
                        TextField("Note", text: self.$newNote)
                            .padding()
                        TextField("Count", text: self.$newCount)
                            .padding()
                        Spacer()
                    }
                    .frame(minWidth: 300.0)
                }
            }
            Divider()
            ScrollView {
                ForEach(counters, id: \.self) { counter in
                    CounterItemView(counter: counter, saveCallBack: self.saveContext)
                        .frame(maxWidth: .infinity)
                        .contextMenu {
                            Button(action: {
                                self.delete(counter: counter)
                            }) {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                }
            }
        }
    }
    
    func addCounter(title: String, note: String, count: String) {
        if (!title.isEmpty && Int64(count) != nil) {
            let newCounter = Counter(context: self.managedObjectContext)
            newCounter.title = title
            newCounter.note = note
            if let countInt: Int64 = Int64(count) {
                newCounter.count = countInt
            }
            self.saveContext()
        }
    }
    
    func delete(counter: Counter) {
        self.managedObjectContext.delete(counter)
        self.saveContext()
    }
    
    func resetPopoverFields() {
        self.newTitle = ""
        self.newNote = ""
        self.newCount = ""
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
