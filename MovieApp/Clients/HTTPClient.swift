//
//  HTTPClient.swift
//  MovieApp
//
//  Created by Anup Saud on 2024-09-09.
//

import Foundation
import Combine
enum NetworkError: Error{
    case badUrl
}
class HTTPClient{
    
    func fetchMoives(search: String) -> AnyPublisher<[Movie],Error>{
       guard let encodedSearch = search.urlEncoded,let url = URL(string: "https://www.omdbapi.com/?s=\(encodedSearch)&page=2&apiKey=appkey") else {
           return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
      return  URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResoponse.self, decoder: JSONDecoder())
            .map(\.Search)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Movie],Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
