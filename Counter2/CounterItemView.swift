//
//  CounterItemView.swift
//  Counter2
//
//  Created by Viraj Chitnis on 7/21/20.
//  Copyright © 2020 Viraj Chitnis. All rights reserved.
//

import SwiftUI

struct CounterItemView: View {
    var counter: Counter
    var saveCallBack: () -> Void
    
    var title: String {
        get {
            if let theTitle = self.counter.title {
                return theTitle
            } else {
                return ""
            }
        }
    }
    var note: String {
        get {
            if let theNote = self.counter.note {
                return theNote
            } else {
                return ""
            }
        }
    }
    var count: String {
        get {
            return "\(self.counter.count)"
        }
    }
    
    var body: some View {
        VStack {
            Text("\(self.title)")
                .font(.headline)
            Text("\(self.note)")
                .foregroundColor(Color.gray)
            HStack {
                Button(action: {
                    self.counter.count -= 1
                    self.saveCallBack()
                }) {
                    Image(systemName: "minus.circle")
                }
                .font(.title)
                Text("\(self.count)")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .padding(.horizontal)
                Button(action: {
                    self.counter.count += 1
                    self.saveCallBack()
                }) {
                    Image(systemName: "plus.circle")
                }
                .font(.title)
            }
        }
        .padding(.all)
    }
}

struct CounterItemView_Previews: PreviewProvider {
    static var previews: some View {
        CounterItemView(counter: Counter(), saveCallBack: {})
    }
}
