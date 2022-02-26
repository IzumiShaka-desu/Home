//
//  File.swift
//  
//
//  Created by Akashaka on 26/02/22.
//

import Combine
import Foundation
protocol HomeRepositoryProtocol {
  func getGames(target: String?) -> AnyPublisher<GamesEntity, Error>
  
}
public final class HomeRepository: NSObject {
  typealias GamesInstance = (HomeRemoteDataSource) -> HomeRepository
  
  fileprivate let remote: HomeRemoteDataSource
  private init( remote: HomeRemoteDataSource) {
    self.remote = remote
  }
  
  static let sharedInstance: GamesInstance = {remoteRepo in
    return HomeRepository(remote: remoteRepo)
  }
}
extension HomeRepository: HomeRepositoryProtocol {
  func getGames(target: String?) -> AnyPublisher<GamesEntity, Error> {
    return self.remote
      .getGames(target: target)
      .map({$0.toEntity()})
      .eraseToAnyPublisher()
  }
  
}
