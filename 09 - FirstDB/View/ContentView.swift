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
                    VStack(alignment: .leading) {
                        Text(grocery.name ?? "unknown")
                            .font(.headline)
                        Text("\(grocery.quantity)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            .onDelete(perform: deleteRow)
            }
                
                
            .navigationBarTitle("Grocery List")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                let groceryItem = Groceries(context: self.moc)
                groceryItem.id = UUID()
                groceryItem.name = "Chicken"
                groceryItem.quantity = Int16.random(in: 1...5)
                try? self.moc.save()
            }) {
                Image(systemName: "plus")
            })
        }
    }
    func deleteRow(at offsets: IndexSet) {
        for offset in offsets {
            let grocery = groceries[offset]
            moc.delete(grocery)
            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
