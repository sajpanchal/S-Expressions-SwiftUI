//
//  ContentView.swift
//  Shared
//
//  Created by saj panchal on 2021-09-15.
//

import SwiftUI

struct ContentView: View {
    @State var myString = ""
   @State var regex = try! NSRegularExpression(pattern:#"[(](add|multiply)\s([0-9]+|[(](add|multiply)\s([0-9]+)\s[0-9]+[)])\s([0-9]+|[(](add|multiply)\s([0-9]+)\s[0-9]+[)])[)]"#)
    
    @State var result = false
    var body: some View {
        VStack {
            TextField("Enter function", text: $myString)
                .padding()
            Button("check") {
               result = regex.matches(myString)
                print(result)
            }
            Text(result ? "pass": "fail")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location:0, length: string.utf16.count)
        return firstMatch(in: string, options:[], range:range) != nil
    }
}
