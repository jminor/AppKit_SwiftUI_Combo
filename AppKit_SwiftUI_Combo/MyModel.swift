//
//  MyModel.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/29/22.
//

import Foundation

class MyModel: ObservableObject {
    // This is the "single source of truth" for this demo app
    @Published var value = 11.0
}
