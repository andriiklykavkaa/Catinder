//
//  HomeViewModel.swift
//  Catinder
//
//  Created by Andrii Klykavka on 12.11.2024.
//

import UIKit
import Combine

class HomeViewModel {
    
    @Published var cat: Cat?
    @Published var isCatLoading: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []

    private let apiService: CatAPIService
    
    init(apiService: CatAPIService) {
        self.apiService = apiService
    }
    
    func fetchCat() {
        isCatLoading = true
        apiService.fetchCats(limit: 1, format: "jpg", breedID: nil)
            .subscribe(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { cats in
                guard let cat = cats.first else { return }
                self.cat = cat
            }
            .store(in: &cancellables)
    }
    
    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        apiService.fetchImage(at: url)
            .sink { _ in
            } receiveValue: { image in
                self.isCatLoading = false
                completion(image)
            }
            .store(in: &cancellables)
    }
}
