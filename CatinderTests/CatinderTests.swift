//
//  CatinderTests.swift
//  CatinderTests
//
//  Created by Roman Mishchenko on 30.10.2024.
//

import XCTest
import Combine
@testable import Catinder

final class CatinderTests: XCTestCase {
    
    var cancellable = Set<AnyCancellable>()
    let apiService = CatAPIService()

    func testFetchCatBreeds() {
        let expectation = XCTestExpectation(description: "Fetch cat breeds")
        
        apiService.fetchCatBreeds()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch cat breeds: \(error)")
                }
            } receiveValue: { breeds in
                XCTAssertFalse(breeds.isEmpty)
                expectation.fulfill()
                
                print("🐈🐈🐈 Cat breeds 🐈🐈🐈")
                for breed in breeds {
                    // You can print here parameters you need
                    print(breed.name)
                }
                print("🐈🐈🐈🐈🐈🐈🐈🐈🐈")
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testRandomCatFetch() {
        let expectation = XCTestExpectation(description: "Fetch random cat image")
        
        apiService.fetchCats()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch random cat image: \(error)")
                }
            } receiveValue: { cats in
                XCTAssertFalse(cats.isEmpty)
                expectation.fulfill()
                
                print("🐈🐈🐈 Random cats 🐈🐈🐈")
                for cat in cats {
                    // You can print here parameters you need
                    print(cat.url)
                }
                print("🐈🐈🐈🐈🐈🐈🐈🐈🐈")
            }
            .store(in: &cancellable)

        wait(for: [expectation], timeout: 5)
    }
    
    func testCatWithBreedFetch() {
        let expectation = XCTestExpectation(description: "Fetch cat with breed")
        
        apiService.fetchCats(breedID: "abys")
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch random cat image: \(error)")
                }
            } receiveValue: { cats in
                XCTAssertFalse(cats.isEmpty)
                expectation.fulfill()
                
                print("🐈🐈🐈 Breed cats 🐈🐈🐈")
                for cat in cats {
                    // You can print here parameters you need
                    print(cat.url)
                }
                print("🐈🐈🐈🐈🐈🐈🐈🐈🐈")
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
    }

    
    func testCatImageFetch() {
        let expectation = XCTestExpectation(description: "Fetch cat image")
        
        apiService.fetchCats()
            .flatMap { [weak self] cats in
                Publishers.MergeMany(
                    cats.compactMap { cat -> AnyPublisher<(Cat, UIImage?), Error> in
                        guard let self, let url = URL(string: cat.url) else {
                            return Just((cat, nil))
                                .setFailureType(to: Error.self)
                                .eraseToAnyPublisher()
                        }
                        return self.apiService.fetchImage(at: url)
                            .map { image in (cat, image) }
                            .eraseToAnyPublisher()
                    }
                )
                .collect()
            }
            .eraseToAnyPublisher()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch random cat image: \(error)")
                }
            } receiveValue: { cats in
                XCTAssertFalse(cats.isEmpty)
                expectation.fulfill()
                
                print("🐈🐈🐈 Random cats with images 🐈🐈🐈")
                for (cat, image) in cats {
                    // You can print here parameters you need
                    print(cat.url)
                    print(image?.size ?? .zero)
                }
                print("🐈🐈🐈🐈🐈🐈🐈🐈🐈")
            }
            .store(in: &cancellable)

        wait(for: [expectation], timeout: 5)
    }

}
