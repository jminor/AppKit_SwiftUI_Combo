//
//  MyContentView.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/29/22.
//

import SwiftUI

struct MyContentView: View {

    @ObservedObject var model: MyModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("SwiftUI")
            Divider()
            ValueAdjuster(value: $model.value)
            Spacer()
        }
//        .onChange(of: model.value, perform: { newValue in
//            print("MyContentView onChange: \(newValue)")
//        })
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
        Slider(value: $value,
               in: 0...100
        ) { editing in
            if editing {
//                print("ValueAdjuster began edit: \(value)")
            }else{
//                print("ValueAdjuster finished edit: \(value)")
            }
        }
        HStack {
            Text("\(value)")
            Spacer()
            Button("-") {
                value -= 1
//                print("-: \(value)")
            }
            Button("+") {
                value += 1
//                print("+: \(value)")
            }
        }
    }
}
