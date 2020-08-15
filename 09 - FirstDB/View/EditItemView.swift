//
//  EditItemView.swift
//  09 - FirstDB
//
//  Created by Kevin Paul on 8/15/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var quantity: String = ""
    var grocery: Groceries
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("\(grocery.name ?? "name")", text: $name)
                    TextField("\(grocery.quantity)", text: $quantity)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Edit Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                let groceryItem = self.grocery
                groceryItem.name = self.name
                groceryItem.quantity = Int16(self.quantity) ?? self.grocery.quantity
                try? self.moc.save()
                
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    .onAppear(perform: loadForm)
    }
    func loadForm() {
        self.name = grocery.name ?? ""
        self.quantity = "\(grocery.quantity)"
    }
}

//struct EditItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditItemView()
//    }
//}
