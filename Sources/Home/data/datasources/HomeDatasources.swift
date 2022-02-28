//
//  File.swift
//  
//
//  Created by Akashaka on 26/02/22.
//

import Combine
import Alamofire
import Foundation
import Common

public protocol HomeRemoteDataSourceProtocol: AnyObject {
  func getGames(target: String?) -> AnyPublisher<GamesResponse, Error>
}
public final class HomeRemoteDataSource: NSObject {

  private override init() { }

 public static let sharedInstance: HomeRemoteDataSource =  HomeRemoteDataSource()

}
 extension HomeRemoteDataSource: HomeRemoteDataSourceProtocol {
 public func getGames(target: String?) -> AnyPublisher<GamesResponse, Error> {
    return Future<GamesResponse, Error> { completion in
      if let url = API.buildUrl(endpoint: .games) {
        AF.request(target ?? url)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }

}
