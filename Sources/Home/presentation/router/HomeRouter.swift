//
//  HomeRouter.swift
//  Gemmu
//
//  Created by Akashaka on 19/02/22.
//

import SwiftUI

open class HomeRouterBase {
public init() {}
 public func makeDetailView(for id: Int) -> some View {

    return DefaultView()
  }
}
 struct DefaultView: View {
  var body: some View {
    HStack {}
  }
}
