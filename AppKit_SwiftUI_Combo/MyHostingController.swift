//
//  MyHostingController.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/28/22.
//

import Foundation
import SwiftUI


struct MyContentView: View {

    @Binding var value: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text("SwiftUI")
            Divider()
            Slider(value: $value,
                   in: 0...100
            ) { editing in
                if editing {
                    print("MyContentView slider began edit: \(value)")
                }else{
                    print("MyContentView slider finished edit: \(value)")
                }
            }
            .onChange(of: value) { newValue in
                // this happens on every change during a slider drag
                print("MyContentView value changed: \(value)")
            }
            Text("\(Int(value))")
            Spacer()
        }
        .padding()
    }

}

protocol MyEditableThing: NSObject {
    dynamic var value: Double { get set }
}

class EditableThingObserver {
    var kvoToken: NSKeyValueObservation?
    var callback: (Double) -> Void

    init(thing: ViewController, callback: @escaping (Double) -> Void) {
        self.callback = callback
        observe(thing: thing)
    }

    func observe(thing: ViewController) {
        kvoToken = thing.observe(\.value, options: .new) { obj, change in
            if let newValue = change.newValue {
                self.callback(newValue)
            }
        }
    }

    deinit {
        kvoToken?.invalidate()
    }
}

// This fella here is the shim between AppKit and SwiftUI
// It acts as an AppKit NSViewController, but it "hosts"
// a SwiftUI view inside of it. This controller should be
// paired with an NSContainerView via the "embed" segue.
class MyHostingController: NSHostingController<MyContentView>
{
    var observer: EditableThingObserver?

    weak var delegate: ViewController? {
        didSet {
            if let delegate {
                observer = EditableThingObserver(thing: delegate) { newValue in
                    if self.rootView.value != newValue {
//                        self.rootView.value = newValue
                        print("Observer -> SET \(newValue)")
                        self.rootView.value = newValue
//                        self.rootView.value.projectedValue.update()
                    }else{
                        print("Observer -> IGNORE \(newValue)")
                    }
                }
            }
        }
    }

    var binding: Binding<Double>?

    required init?(coder: NSCoder) {
        let catch22 = MyContentView(value: Binding(get: {
            return 0
        }, set: { newValue in
            print("FAKE binding got \(newValue)")
        }))

        super.init(rootView: catch22)

        binding = Binding(get: {
            return self.delegate?.value ?? 0
        }, set: { newValue in
//            print("Binding got \(newValue)")
            if let delegate = self.delegate {
                if delegate.value != newValue {
                    delegate.value = newValue
                }
            }
        })
        self.rootView = MyContentView(value: binding!)
    }
}
