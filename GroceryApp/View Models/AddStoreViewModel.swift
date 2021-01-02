//
//  AddStoreViewModel.swift
//  GroceryApp
//
//  Created by yao on 13/12/20.
//

import Foundation

class AddStoreViewModel: ObservableObject {
    
    private var fireStoreManager: FirestoreManager
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    var name: String = ""
    var address: String = ""
    
    init() {
        fireStoreManager = FirestoreManager()
    }
    
    
    func save() {
        
        let store = Store(name: name, address: address)
        fireStoreManager.save(store: store) { result in
            switch result {
                case .success(let store):
                    DispatchQueue.main.async {
                        self.saved = store == nil ? false : true
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.message = Constants.Messages.storeSavedFailure
                    }
            }
        }
    }

    
    
}
