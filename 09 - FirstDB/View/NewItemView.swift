//
//  NewItemView.swift
//  09 - FirstDB
//
//  Created by Kevin Paul on 8/15/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import SwiftUI

struct NewItemView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var quantity: String = ""
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("name", text: $name)
                    TextField("quantity", text: $quantity)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Add Grocery Item", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
                }, trailing: Button("Save"){
                    
                    let groceryItem = Groceries(context: self.moc)
                    groceryItem.id = UUID()
                    groceryItem.name = self.name
                    groceryItem.quantity = Int16(self.quantity) ?? 0
                    try? self.moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView()
    }
}
