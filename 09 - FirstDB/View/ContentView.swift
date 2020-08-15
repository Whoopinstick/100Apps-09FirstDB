//
//  ContentView.swift
//  09 - FirstDB
//
//  Created by Kevin Paul on 8/14/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: Groceries.entity(), sortDescriptors: []) var groceries: FetchedResults<Groceries>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        NavigationView {
            List {
                ForEach(groceries, id: \.id) {grocery in
                    Text(grocery.name ?? "unknown")
                }
            }
                
                
                .navigationBarTitle("Grocery List")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    
                }) {
                    Image(systemName: "plus")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
