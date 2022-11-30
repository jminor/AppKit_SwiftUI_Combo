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
    required init?(coder: NSCoder) {
        // This temporary model will get replaced later
        super.init(rootView: MyContentView(model: MyModel()))
    }
}
