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
    @ObservedObject var model = MyModel() {
        didSet {
            // If we're given a new model, reconstruct our SwiftUI view
            self.rootView = MyContentView(model: model)
        }
    }

    required init?(coder: NSCoder) {
        // TODO: Why can't we use self.model here?
        super.init(rootView: MyContentView(model: MyModel()))
        // After super.init, we can reset this
        self.rootView = MyContentView(model: model)
    }
}
