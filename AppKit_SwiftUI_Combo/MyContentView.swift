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
            ValueAdjuster(value: $model.value)
            Spacer()
        }
        .onChange(of: model.value, perform: { newValue in
            print("MyContentView onChange: \(newValue)")
        })
        .padding()
    }
}

struct MyContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        MyContentView(model: MyModel())
    }
}

struct ValueAdjuster: View {
    @Binding var value: Double

    var body: some View {
        HStack {
            Text("\(value)")
            Spacer()
            Button("-") {
                value -= 1
                print("-: \(value)")
            }
            Button("+") {
                value += 1
                print("+: \(value)")
            }
        }
    }
}
