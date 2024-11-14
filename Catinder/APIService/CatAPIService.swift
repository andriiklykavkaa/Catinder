import Foundation
import Combine
import UIKit

/// The API endpoint for the Cat API.
private enum APIEndpoint {
    
    // Here we use force unwrap to implement a fail-fast approach.
    static let baseURL = URL(string: "https://api.thecatapi.com/v1")!
    
    static let apiKey = "live_omsXmrBixsLOb0pUdZw03Mt2zo00ZjAj4oKXEaJ7Eun9ixDGE2KHqbemqSFLTk2Y" // Replace with your API key from thecatapi.com. PLEASE DO NOT COMMIT YOUR API KEY TO SOURCE CONTROL.
}

/// The protocol for the Cat API service.
protocol CatAPIServiceType {
    /// Fetches an image from the given URL.
    /// - Parameter url: The URL of the image to fetch.
    /// - Returns: A publisher that emits the image or an error.
    func fetchImage(at url: URL) -> AnyPublisher<UIImage?, Error>
    
    /// Fetches a random cat images.
    /// - Parameters:
    ///  - limit: The number of images to fetch.
    ///  - format: The format of the images to fetch (for example jpg).
    ///  - breedID: The ID of the breed to fetch images for.
    ///  - Returns: A publisher that emits an array of cat images or an error.
    ///  - Note: If breedID is nil, random images will be fetched.
    func fetchCats(limit: Int, format: String, breedID: String?) -> AnyPublisher<[Cat], Error>
    
    /// Fetches cat breeds.
    /// - Returns: A publisher that emits an array of cat breeds or an error.
    func fetchCatBreeds() -> AnyPublisher<[Breed], Error>
}

/// Default implementation of the Cat API service.
final class CatAPIService: CatAPIServiceType {
    private var cancellable = Set<AnyCancellable>()
    
    func fetchImage(at url: URL) -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .map { UIImage(data: $0) }
            .mapError { $0 as Error } // Convert URLError to a general Error type
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCats(limit: Int = 1, format: String = "jpg", breedID: String? = nil) -> AnyPublisher<[Cat], Error> {
        let randomCatURL = APIEndpoint.baseURL.appendingPathComponent("images/search")
        
        guard var components = URLComponents(string: randomCatURL.path) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "mime_types", value: format)
        ]
        
        if let breedID {
            queryItems.append(.init(name: "breed_id", value: breedID))
        }
        
        components.queryItems = queryItems
        
        var request = URLRequest(url: randomCatURL)
        request.addValue(APIEndpoint.apiKey, forHTTPHeaderField: "x-api-key")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Cat].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCatBreeds() -> AnyPublisher<[Breed], Error> {
        let breedsURL = APIEndpoint.baseURL.appendingPathComponent("breeds")
        
        var request = URLRequest(url: breedsURL)
        request.addValue(APIEndpoint.apiKey, forHTTPHeaderField: "x-api-key")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Breed].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
