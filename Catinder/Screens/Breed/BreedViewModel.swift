//
//  BreedViewModel.swift
//  Catinder
//
//  Created by Andrii Klykavka on 12.11.2024.
//

import UIKit
import Combine

class BreedViewModel {
    
    @Published var breeds: [Breed] = []
    @Published var isBreedsLoading: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let apiService: CatAPIService
    
    init(apiService: CatAPIService) {
        self.apiService = apiService
    }
    
    func fetchBreeds() {
        isBreedsLoading = true
        apiService.fetchCatBreeds()
            .sink { _ in
                self.isBreedsLoading = false
            } receiveValue: { breeds in
                self.breeds = breeds
                print(breeds)
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
                completion(image)
            }
            .store(in: &cancellables)
    }
}
