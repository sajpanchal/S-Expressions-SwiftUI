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
    @State var subRegex = try! NSRegularExpression(pattern:#"[(](add|multiply)\s([0-9]+)\s[0-9]+[)]"#)
    @State var flag = true
    @State var result = true
    @State var answer = 0
    @State var answerString = "Please Proceed.."
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter function", text: $myString)
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                Button("check") {
                    answerString = ""
                    answer = 0
                    subString = myString
                    flag = true
                    
                    if result {
                       while flag {
                        print(subString)
                            let matchedString = findSubString()
                        
                        if matchedString == "" {
                            answerString = "Invalid s-expression syntax."
                            break
                        }
                           let matchedArr = matchedString.components(separatedBy: CharacterSet(charactersIn: " ()"))
                            if matchedArr[1] == "add" {
                               let result = add(exp1: matchedArr[2], exp2: matchedArr[3])
                                subString = subString.replacingOccurrences(of: matchedString, with: result)
                            }
                            else if matchedArr[1] == "multiply" {
                                let result = multiply(exp1: matchedArr[2], exp2: matchedArr[3])
                                 subString = subString.replacingOccurrences(of: matchedString, with: result)
                            }
                        if subString.contains("add") || subString.contains("multiply") {
                            flag = true
                        }
                        else {
                            flag = false
                            if let ans = Int(subString) {
                                answer = ans
                            }
                            else {
                                answerString = "Invalid s-expression syntax."
                            }
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
                Text(answerString == "" || answerString == "Please Proceed.." ? "Calculation: \(answer)" : answerString)
            }
        }
      
    }
    
    func findSubString() -> String {
        let matches = subRegex.matches(in: subString, options: [], range: NSRange(location: 0, length: subString.utf16.count))
        if let match = matches.first {
            let range = match.range(at: 0)
            if let swiftRange = Range(range, in: subString) {
                let result = subString[swiftRange]
               // print("substring is: ",result)
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

