//
//  MyHostingController.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/28/22.
//

import Foundation
import SwiftUI


// This fella here is the shim between AppKit and SwiftUI
// It acts as an AppKit NSViewController, but it "hosts"
// a SwiftUI view inside of it. This controller should be
// paired with an NSContainerView via the "embed" segue.
class MyHostingController: NSHostingController<MyContentView>
{
    @ObservedObject var model = MyModel()

    required init?(coder: NSCoder) {
        let catch22 = Binding<Double>(get: {0}, set: {
            newValue in
            print("AAAA!!!!")
        })
        super.init(rootView: MyContentView(val: catch22))
        self.rootView = MyContentView(val: $model.value)
    }

    func setModel(_ m: MyModel) {
        model = m
        self.rootView = MyContentView(val: $model.value)
    }
}
