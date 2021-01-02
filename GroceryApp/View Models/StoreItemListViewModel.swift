//
//  StoreItemListViewModel.swift
//  GroceryApp
//
//  Created by yao on 15/12/20.
//

import Foundation

struct StoreItemViewState {
    var name: String = ""
    var price: String = ""
    var quantity: String = ""
}

struct StoreItemViewModel {
    
    let storeItem: StoreItem
    
    var storeItemId: String {
        
        storeItem.id ?? ""
    }
    
    var name: String {
        storeItem.name
    }
    
    var price: Double {
        storeItem.price
    }
    
    var quantity: Int {
        storeItem.quantity
    }
}


class StoreItemListViewModel: ObservableObject {
    
    private var fireStoreManager: FirestoreManager
    var groceryItemName: String = ""
    @Published var store: StoreViewModel?
    @Published var storeItems: [StoreItemViewModel] = []
    
    
    var storeItemViewState =  StoreItemViewState()
    
    init() {
        fireStoreManager = FirestoreManager()
    }
    
    func deleteStoreItemBy(storeId: String, storeItemId: String) {
        
        fireStoreManager.deleteStoreItem(storeId: storeId, storeItemId: storeItemId) { (error) in
            if error == nil {
                self.getStoreItemsBy(storeId: storeId)
            }
        }
    }
    
    
    func getStoreItemsBy(storeId: String) {
        
        fireStoreManager.getStoreItemBy(storeId: storeId) { result in
            switch result {
                case .failure(let error):
                    print(error.localizedDescription)
            case .success(let items):
                if let items = items {
                    DispatchQueue.main.async {
                        self.storeItems = items.map(StoreItemViewModel.init)
                    }
                }
            }
        }
        
    }
    
    func getStoreById(storeId: String) {
        fireStoreManager.getStoreById(storeId: storeId) { (result) in
            switch result {
                case .success(let store):
                    if let store = store {
                        DispatchQueue.main.async {
                            self.store = StoreViewModel(store: store)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func addItemToStore(storeId: String, completion: @escaping (Error?) -> Void) {
        
        fireStoreManager.updateStore(storeId: storeId, storeItem: StoreItem.from(storeItemViewState)) { (result) in
            switch result {
                case .success(_):
                    completion(nil)
                case .failure(let error):
                    completion(error)
                
            }
        }
    }
    
//    func addItemToStore(storeId: String) {
//
//        fireStoreManager.updateStore(storeId: storeId, values: ["items": [groceryItemName]]) { (result) in
//            switch result {
//                case .success(let storeModel):
//                    if let model = storeModel {
//                        DispatchQueue.main.async {
//                            self.store = StoreViewModel(store: model)
//                        }
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//            }
//        }
//    }
    
}
