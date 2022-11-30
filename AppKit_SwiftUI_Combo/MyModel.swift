//
//  MyModel.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/29/22.
//

import Foundation

class MyModel: ObservableObject {
    @Published var value = 11.0
//    {
//        willSet {
//            self.objectWillChange.send()
//        }
//        didSet {
//            print("MyModel didSet \(value)")
//        }
//    }
}
