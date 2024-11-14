//
//  LikesViewModel.swift
//  Catinder
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import Combine

class LikesViewModel {
    private var cancellables: Set<AnyCancellable> = []
    
    private let apiService: CatAPIService
    
    init(apiService: CatAPIService) {
        self.apiService = apiService
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
