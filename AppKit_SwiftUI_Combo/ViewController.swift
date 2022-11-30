//
//  ViewController.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/28/22.
//

import Cocoa

class ViewController: NSViewController {

    var model: MyModel?

    @objc dynamic var value: Double {
        get {
            return model?.value ?? 11
        }
        set {
            model?.value = newValue
        }
    }

    @IBAction func more(_ sender: Any?) {
        model?.value += 1// model.value + 1
        print("more: \(model?.value ?? -1)")
    }

    @IBAction func less(_ sender: Any?) {
        model?.value -= 1// model.value - 1
        print("less: \(model?.value ?? -1)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let hostingController = segue.destinationController as? MyHostingController {
//            hostingController.setModel(model)
            model = hostingController.model
        }
    }
}

