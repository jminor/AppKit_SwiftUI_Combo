//
//  ViewController.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/28/22.
//

import Cocoa

class ViewController: NSViewController {

    var model = MyModel()

    // Expose this so that controls in the Storyboard can bind to "self.value"
    @objc dynamic var value: Double
    {
        get {
            return model.value
        }
        set {
            model.value = newValue
        }
    }

    @IBAction func more(_ sender: Any?) {
        model.value += 1
    }

    @IBAction func less(_ sender: Any?) {
        model.value -= 1
    }

    var listener: Any?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Watch for changes in the model (e.g. from MyContentView)
        // It will stop listening when 'listener' is deallocated (or cancelled)
        listener = model.$value.sink { newValue in
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

//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let hostingController = segue.destinationController as? MyHostingController {
            // Use OUR model
            hostingController.rootView.model = model
        }
    }
}

