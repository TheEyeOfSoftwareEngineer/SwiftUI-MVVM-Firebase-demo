//
//  StoreListViewModel.swift
//  GroceryApp
//
//  Created by yao on 15/12/20.
//

import Foundation

class StoreListViewModel: ObservableObject {
    
    private var fireStoreManager: FirestoreManager
    @Published var stores: [StoreViewModel] = []
    
    init() {
        fireStoreManager = FirestoreManager()
    }
    
    func getAll() {
        
        fireStoreManager.getAllStores { result in
            
            switch result {
                case .success(let stores):
                    if let stores = stores {
                        DispatchQueue.main.async {
                            self.stores = stores.map(StoreViewModel.init)
                        }
                    }
                
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
    
}

struct StoreViewModel {
    
    let store: Store
    
    var storeId: String {
        store.id ?? ""
    }
    
    var name: String {
        store.name
    }
    
    var address: String {
        store.address
    }
    
    var items: [String] {
        store.items ?? []
    }
    
}
