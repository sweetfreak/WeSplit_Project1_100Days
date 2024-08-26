//
//  ContentView.swift
//  WeSplit
//
//  Created by Jesse Sheehan on 7/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0 // two way binding!
    @State private var numberOfPeople = 2 // two way binding!
    @State private var tipPercentage = 20 //two way binding!
    @FocusState private var amountIsFocused: Bool
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return (checkAmount + tipValue)
    }
    
    var totalPerPerson: Double {
        //calculate total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    let tipPercentages = [10, 15, 18, 20, 25, 30, 0]
    
    
    var body: some View {
        //Text("We Split")
        NavigationStack {
            Form {
                Section("Check Total and Guests") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    //could do code:"USD" but can also ask iOS to get the system's default value w/ locale
                    //that code looks for a default currency, if there is one, use it (identifier), and otherwise( nil coalessing - ??) use "USD"
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker ("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                //TIP SECTION
                Section("Tip Percentage") {
                    NavigationStack {
                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(0..<101, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                }
                
                Section("Grand Total") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage > 0 ? .primary : Color.red)
                    
                }
                
                //final result
                Section("Amount  per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            //this needs to be INSIDE the navigation stack:soun
            .navigationTitle("We Split")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }

    }
}
            //SECTIONS, BODY VIEW, FORMS
//this is where we'll be doin most of the coding. it's all User Interface stuff here.
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section {
//                    Text("Hello World!1")
//                    Text("Hello World!3")
//                }
//                Section{
//                    Text("Hello World!2")
//                    Text("Hello World!3")
//                    Text("Hello World!3")
//                    Text("Hello World!3")
//                }
//                .navigationTitle("SwiftUI")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//    }
//}
                    // BUTTON, @STATE, VARIABLES
//struct ContentView: View {
//    @State private var tapCount = 0
//    
//    var body: some View {
//        Button("Tap Count is \(tapCount)") {
//            //but structs can't be changed, they're constants (mostly)
//            //Can't call them "mutating" either - only functions do that
//            //need @State to let swift let you change it.
//            //RECOMMENDED: Make @State private to signal they can only be used there, in that context
//            tapCount += 1
//        }
//    }
//}
                        //2 WAY BINDING - use $ to let user get AND set a variable
//struct ContentView: View {
//    @State private  var name = ""
//    
//    var body: some View {
//        Form {
//                                        //$name - tells swift to read AND write the value
//            TextField("Enter Your Name", text: $name)
//            Text("Your name is \(name)")
//        }
//    }
//}

                    //VIEWS WITH FOR EACH LOOPS + arrays, PICKERS, 2way binding,
//struct ContentView: View {
//    let students = ["Harry", "Hermione", "Ron"]
//    @State private var selectedStudent = "Harry"
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Picker("Select your student", selection: $selectedStudent) {
//                    ForEach(students, id: \.self) {
                              //  // id: \.self <- swift needs to know how to tell each string apart - this is particularly helpful with arrays/collections? this says "The string, itself is its unique identifier. But if there are repeating names in the array, you MAY run into issues.
//                        Text($0)
//                    }
//                }
//            }
//            .navigationTitle("Select a Student")
//        }
//    }
//}

#Preview {
    ContentView()
}
