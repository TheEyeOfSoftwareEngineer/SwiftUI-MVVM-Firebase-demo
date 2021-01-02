//
//  StoreItemsListView.swift
//  GroceryApp
//
//  Created by yao on 15/12/20.
//

import SwiftUI
//import Combine

struct StoreItemsListView: View {
    
//    @State var store: StoreViewModel
    var store: StoreViewModel
    @StateObject private var storeItemListVM = StoreItemListViewModel()
//    @State var cancellable: AnyCancellable?
    
    private func deleteStoreItem(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let storeItem = storeItemListVM.storeItems[index]
            storeItemListVM.deleteStoreItemBy(storeId: store.storeId, storeItemId: storeItem.storeItemId)
        }
    }
    
    
    var body: some View {
        
        VStack {
            
            TextField("Enter item name", text: $storeItemListVM.storeItemViewState.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter item price", text: $storeItemListVM.storeItemViewState.price)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter item quantity", text: $storeItemListVM.storeItemViewState.quantity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
//                storeItemListVM.addItemToStore(storeId: store.storeId)
                storeItemListVM.addItemToStore(storeId: store.storeId) { (error) in
                    
                    if error == nil {
                        storeItemListVM.getStoreItemsBy(storeId: store.storeId)
                    }
                    
                }
            }

            // version 0.0
//            List(store.items, id:\.self) { item in
//                Text(item)
//            }

            //version 0.1
//            if let store = storeItemListVM.store {
//                List(store.items, id:\.self) { item in
//                    Text(item)
//                }
//            }
            //version 0.2
//            List(storeItemListVM.storeItems, id: \.name) { item in
//                Text(item.name)
//            }
            // version 0.3
            List {
                
                ForEach(storeItemListVM.storeItems, id: \.storeItemId) { storeItem in
                    Text(storeItem.name)
                }.onDelete(perform: deleteStoreItem)
            }
            
            
            Spacer()
            
            .onAppear {
                // version 0.2
                storeItemListVM.getStoreItemsBy(storeId: store.storeId)
                // version 0.1
//                storeItemListVM.getStoreById(storeId: store.storeId)
                    //vwesion 0.0
//                cancellable = storeItemListVM.$store.sink { value in
//                    if let value = value {
//                        store = value
//                    }
//                }
            }
        }
        
        
    }
}

struct StoreItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemsListView(store: StoreViewModel(store: Store(id: "123", name: "HEB", address: "1200 Ave", items: nil)))
    }
}
