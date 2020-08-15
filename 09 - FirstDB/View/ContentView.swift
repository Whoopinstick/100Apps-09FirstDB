//
//  ContentView.swift
//  09 - FirstDB
//
//  Created by Kevin Paul on 8/14/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: Groceries.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Groceries.name, ascending: true)]) var groceries: FetchedResults<Groceries>
    @Environment(\.managedObjectContext) var moc
    @State private var isShowingSheet = false
    var body: some View {
        NavigationView {
            List {
                ForEach(groceries, id: \.id) {grocery in
                    NavigationLink(destination: EditItemView(grocery: grocery)) {
                        VStack(alignment: .leading) {
                            Text(grocery.name ?? "unknown")
                                .font(.headline)
                            Text("\(grocery.quantity)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteRow)
            }
                
                
            .navigationBarTitle("Grocery List")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.isShowingSheet.toggle()
            }) {
                Image(systemName: "plus")
            })
        }
            
        .sheet(isPresented: $isShowingSheet) {
            NewItemView().environment(\.managedObjectContext, self.moc)
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
