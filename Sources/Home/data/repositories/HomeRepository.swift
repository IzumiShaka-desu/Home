//
//  File.swift
//  
//
//  Created by Akashaka on 26/02/22.
//

import Combine
import Foundation
public protocol HomeRepositoryProtocol {
  func getGames(target: String?) -> AnyPublisher<GamesEntity, Error>

}
public final class HomeRepository: NSObject {
  typealias HomeInstance = (HomeRemoteDataSource) -> HomeRepository

  fileprivate let remote: HomeRemoteDataSource
  private init( remote: HomeRemoteDataSource) {
    self.remote = remote
  }

  public static let sharedInstance: HomeInstance = {remoteRepo in
    return HomeRepository(remote: remoteRepo)
  }
}
public extension HomeRepository: HomeRepositoryProtocol {
 public func getGames(target: String?) -> AnyPublisher<GamesEntity, Error> {
    return self.remote
      .getGames(target: target)
      .map({$0.toEntity()})
      .eraseToAnyPublisher()
  }

}
