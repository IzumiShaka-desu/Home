//
//  HomeInteractor.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//

import Foundation
import Combine

public protocol HomeUseCase {

  func getGames(target: String?) -> AnyPublisher<GamesEntity, Error>

}

public class HomeInteractor: HomeUseCase {

  private let repository: HomeRepositoryProtocol

  public init(repository: HomeRepositoryProtocol) {
    self.repository = repository
  }

  public func getGames(target: String?) -> AnyPublisher<GamesEntity, Error> {
    return repository.getGames(target: target)
  }

}
