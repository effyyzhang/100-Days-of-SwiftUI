//
//  ContentView.swift
//  BetterRest
//
//  Created by Effy Zhang on 11/21/20.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlter = false
    @State private var recommendedSleepTime = "10:38 PM"
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form{
                
                Section(header: Text("Recommended sleep time")){
                    Text(recommendedSleepTime)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                }
                
                Section(header: Text("When do you want to wake up?")){
                    DatePicker("Please enter a date",
                               selection: $wakeUp, displayedComponents:.hourAndMinute)
                            .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .onChange(of: wakeUp, perform: { value in
                            calculateBedtime()
                        })

                    
                }
                
                Section(header: Text("Desired amount of sleep")){
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                        Text("\(sleepAmount, specifier:"%g") hours")
                    }
                    .onChange(of: sleepAmount, perform: { value in
                        calculateBedtime()
                    })
                }
                
                Section(header: Text("Daily coffee intake")){
                    Picker(selection: $coffeeAmount, label: Text("Coffee amount")){
                        ForEach((1...20), id:\.self) {
                            if ($0 == 1){
                                Text("\($0) cup")
                            }
                            else{
                                Text("\($0) cups")
                            }
                            
                        }
                    }
                    .onChange(of: coffeeAmount, perform: { value in
                        calculateBedtime()
                    })
                    
                    
                }
            }
            .navigationTitle("BetterRest")
            .alert(isPresented: $showingAlter){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }

    }
    func calculateBedtime(){
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do{
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            recommendedSleepTime = formatter.string(from: sleepTime)

    
        } catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem caluculating your bedtime"
            showingAlter = true
        }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
