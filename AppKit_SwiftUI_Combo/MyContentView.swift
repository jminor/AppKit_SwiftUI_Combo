//
//  MyContentView.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/29/22.
//

import SwiftUI

struct MyContentView: View {

//    @Binding var val: Double
    @ObservedObject var model: MyModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("SwiftUI")
            Divider()
            Slider(value: $model.value,
                   in: 0...100
            ) { editing in
                if editing {
                    print("MyContentView slider began edit: \(model.value)")
                }else{
                    print("MyContentView slider finished edit: \(model.value)")
                }
            }
            HStack {
                Text("\(Int(model.value))")
                Spacer()
                Button("-") {
                    model.value -= 1
                    print("-: \(model.value)")
                }
                Button("+") {
                    model.value += 1
                    print("+: \(model.value)")
                }
            }
            Spacer()
        }
//        .onChange(of: model.value) { newValue in
//            // this happens on every change during a slider drag
//            print("MyContentView value changed: \($model.value)")
//        }
        .padding()
    }
}

/*
struct MyContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        @State var demoVal = 6.0
        MyContentView(val: $demoVal)
    }
}
*/
