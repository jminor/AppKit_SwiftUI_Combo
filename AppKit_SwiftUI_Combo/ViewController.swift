//
//  ViewController.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/28/22.
//

import Cocoa

class ViewController: NSViewController {

    var model: MyModel? {
        didSet {
            // Stop listening to a previous model, if any.
            listener = nil
            // Watch for changes in the model (e.g. from MyContentView)
            // It will stop listening when 'listener' is deallocated (or cancelled)
            listener = model?.$value.sink { newValue in
                //print("Changing from \(self.model.value) to \(newValue)")
                // We need to send both willChangeValue and didChangeValue
                // but this 'sink' happens during the @Published property's willSet
                // so we can only do willChangeValue right here.
                self.willChangeValue(for: \.value)
                // Queue up the didChangeValue to happen on the main thread very soon
                // TODO: Is there a better way to guarantee the right order happens?
                DispatchQueue.main.async {
                    self.didChangeValue(for: \.value)
                }
            }
        }
    }
    var listener: Any?

    // Expose this so that controls in the Storyboard can bind to "self.value"
    @objc dynamic var value: Double
    {
        get {
            return model?.value ?? 0
        }
        set {
            model?.value = newValue
        }
    }

    @IBAction func more(_ sender: Any?) {
        model?.value += 1
    }

    @IBAction func less(_ sender: Any?) {
        model?.value -= 1
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let hostingController = segue.destinationController as? MyHostingController {
            // When the hosting controller's SwiftUI view is embedded,
            // we grab a reference to the model.
            model = hostingController.rootView.model
        }
    }
}
