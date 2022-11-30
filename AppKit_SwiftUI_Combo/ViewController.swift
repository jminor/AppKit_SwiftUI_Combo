//
//  ViewController.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/28/22.
//

import Cocoa

class ViewController: NSViewController {

    var model = MyModel()

    // Exposed this so that controls in the Storyboard can bind to .value
    @objc dynamic var value: Double {
        get {
            return model.value
        }
        set {
            model.value = newValue
        }
    }

    @IBAction func more(_ sender: Any?) {
        model.value += 1// model.value + 1
        print("more: \(model.value)")
    }

    @IBAction func less(_ sender: Any?) {
        model.value -= 1// model.value - 1
        print("less: \(model.value)")
    }

    var listener: Any?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Watch for changes in the model (e.g. from MyContentView)
        // It will stop listening when 'listener' is deallocated (or cancelled)
        listener = model.$value.sink { newValue in
            self.willChangeValue(for: \.value)
            // already changed actually...
            self.didChangeValue(for: \.value)
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let hostingController = segue.destinationController as? MyHostingController {
            // Use OUR model
            hostingController.model = model
        }
    }
}

