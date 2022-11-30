//
//  MyContentView.swift
//  AppKit_SwiftUI_Combo
//
//  Created by Joshua Minor on 11/29/22.
//

import SwiftUI

struct MyContentView: View {

    @Binding var val: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text("SwiftUI")
            Divider()
            Slider(value: $val,
                   in: 0...100
            ) { editing in
                if editing {
                    print("MyContentView slider began edit: \(val)")
                }else{
                    print("MyContentView slider finished edit: \(val)")
                }
            }
            HStack {
                Text("\(Int(val))")
                Spacer()
                Button("-") {
                    val -= 1
                    print("-: \(val)")
                }
                Button("+") {
                    val += 1
                    print("+: \(val)")
                }
            }
            Spacer()
        }
        .onChange(of: val) { newValue in
            // this happens on every change during a slider drag
            print("MyContentView value changed: \(val)")
        }
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
