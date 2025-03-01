//
//  AddStoreView.swift
//  GroceryApp
//
//  Created by yao on 15/12/20.
//

import SwiftUI

struct AddStoreView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addStoreVM = AddStoreViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $addStoreVM.name)
                TextField("Address", text: $addStoreVM.address)
                HStack {
                    Spacer()
                    Button("Save") {
                        addStoreVM.save()
                    }.onChange(of: addStoreVM.saved, perform: { value in
                        if value {
                            presentationMode.wrappedValue.dismiss()
                        }
                    })
                    Spacer()
                }
                
                Text(addStoreVM.message)
            }
        }.navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName:"xmark")
        }))
        .navigationTitle("Add new Store")
        .embedInNavigationView()
    }
}

struct AddStoreView_Previews: PreviewProvider {
    static var previews: some View {
        AddStoreView()
    }
}
