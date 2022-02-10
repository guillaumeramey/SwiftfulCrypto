//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 10/02/2022.
//

import Combine
import Foundation

class NetworkingManager {
  enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown

    var errorDescription: String? {
      switch self {
      case .badURLResponse(let url): return "Bad response from URL: \(url)"
      case .unknown: return "Unknown error."
      }
    }
  }

  static func download(url: URL) -> AnyPublisher<Data, Error> {
    URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { try handleUrlResponse(output: $0, url: url) }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }

  static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
    guard let response = output.response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
          }
    return output.data
  }

  static func handleCompletion(completion: Subscribers.Completion<Error>) {
    switch completion {
    case .failure(let error):
      print(error.localizedDescription)
    case .finished:
      break
    }
  }
}
