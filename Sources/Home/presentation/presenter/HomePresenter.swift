//
//  HomePresenter.swift
//  Gemmu
//
//  Created by Akashaka on 18/02/22.
//

import SwiftUI
import Combine

public class HomePresenter<DetailView: View>: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  private let homeUseCase: HomeUseCase
  let router: ((_ id: Int) -> DetailView)
  @Published var games: [GameItemEntity] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = true
  @Published var isError: Bool = false
  var next: String?

 public init(homeUseCase: HomeUseCase, router: @escaping ((Int) -> DetailView)) {
    self.homeUseCase = homeUseCase
    self.router = router
  }

 public func getGames() {
    if next == nil {
      isLoading = true
    }
    homeUseCase.getGames(target: next)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { result in
        self.next = result.next
        self.games.append(contentsOf: result.results)
      })
      .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for id: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: self.router(id)) { content() }
    .padding(0)
    .buttonStyle(PlainButtonStyle())
  }

}
