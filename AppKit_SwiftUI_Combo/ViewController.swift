//
//  ViewController.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/28/22.
//

import Cocoa

@objc class ViewController: NSViewController, MyEditableThing {

    @objc dynamic var value = 0.0 {
        didSet {
            print("VC value \(value)")
        }
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
            hostingController.delegate = self
        }
    }
}

