//
//  NetworkingManager.swift
//  TokenTrend
//
//  Created by Arghadeep Chakraborty on 4/8/24.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad Response from the URL: \(url)"
            case .unknown: return "[⚠️] Unknown Error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        // dataTaskPublisher is always on background thread
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleResponse(output: $0, url: url)})
            // adding this to just be sure if the server is not down
            .retry(2)
            .eraseToAnyPublisher()
    }
    
    private static func handleResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
