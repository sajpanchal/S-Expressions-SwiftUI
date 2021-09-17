//
//  ContentView.swift
//  Shared
//
//  Created by saj panchal on 2021-09-15.
//

import SwiftUI

struct ContentView: View {
    @State var myString = ""
    @State var subString = ""
   // @State var regex = try! NSRegularExpression(pattern:#"[(](add|multiply)\s([0-9]+|[(](add|multiply)\s([0-9]+)\s[0-9]+[)])\s([0-9]+|[(](add|multiply)\s([0-9]+)\s[0-9]+[)])[)]"#)
    @State var regex = try! NSRegularExpression(pattern: #"([(](add|multiply)\s((([0-9]|((\?1))))\s([0-9]|((\?1)))[)]))"#)
    @State var subRegex = try! NSRegularExpression(pattern:#"[(](add|multiply)\s([0-9]+)\s[0-9]+[)]"#)
    @State var flag = true
    @State var result = false
    @State var answer = 0
    @State var answerString = "Please proceed..."
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter function", text: $myString)
                    .padding()
                    .multilineTextAlignment(.center)
    
                Spacer()
                Button("check") {
                    answer = 0
                    subString = myString
                    flag = true
                    result = regex.matches(myString)
                    print(result)
                    if result {
                        
                       while flag {
                            let matchedString = findSubString()
                           let matchedArr = matchedString.components(separatedBy: CharacterSet(charactersIn: " ()"))
                            if matchedArr[1] == "add" {
                               let result = add(exp1: matchedArr[2], exp2: matchedArr[3])
                                print(subString, matchedString, result)
                                subString = subString.replacingOccurrences(of: matchedString, with: result)
                               // print(subString)
                                
                            }
                            else if matchedArr[1] == "multiply" {
                                let result = multiply(exp1: matchedArr[2], exp2: matchedArr[3])
                                 print(subString, matchedString, result)
                                 subString = subString.replacingOccurrences(of: matchedString, with: result)
                               // print(subString, subString.count)
                            }
                        if subString.contains("add") || subString.contains("multiply") {
                            flag = true
                            //print("FLAG:",flag)
                        }
                        else {
                            flag = false
                          
                            //print("FLAG:",flag)
                            answer = Int(subString)!
                            break
                        }
                            
                       }
                                
                    }
                    else {
                        answerString = "Invalid s-expression syntax."
                    }
                }
                .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(16)
                Spacer()
                Text(result ? "Calculation: \(answer)" : answerString)
            }
        }
      
    }
    
    func findSubString() -> String {
        let matches = subRegex.matches(in: subString, options: [], range: NSRange(location: 0, length: subString.utf16.count))
        if let match = matches.first {
            let range = match.range(at: 0)
            if let swiftRange = Range(range, in: subString) {
                let result = subString[swiftRange]
                return String(result)
            }
        }
        return ""
    }
    
    func add(exp1:String, exp2: String) -> String {
        let result = Int(exp1)! + Int(exp2)!
        return String(result)
    }
    func multiply(exp1:String, exp2: String) -> String {
        let result = Int(exp1)! * Int(exp2)!
        return String(result)
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
