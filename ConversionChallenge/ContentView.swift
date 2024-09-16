//
//  ContentView.swift
//  ConversionChallenge
//
//  Created by Mobile on 9/9/24.
//

import SwiftUI

struct ContentView: View 
{
    @State private var inputType = "Seconds"
    @State private var outputType = "Seconds"
    let types = ["Seconds", "Minutes", "Hours", "Days"]
    @State private var input = 0.0	
    var output: Double
    {
        var inputIndx = 0
        var outputIndx = 0
        let inputDbl = Double(input)
        
        var count = 0
        while count < types.count
        {
            if (inputType == types[count])
            {
                inputIndx = count
            }
            if (outputType == types[count])
            {
                outputIndx = count
            }
            count += 1
        }
        
        var diff = 0
        
        if (inputIndx < outputIndx)
        {
            diff = outputIndx - inputIndx
            if outputIndx == 3 { diff -= 1 }
            
            let divisor = pow(60.0, Double(diff))
            
            if outputIndx == 3 { return (inputDbl / divisor) / 24.0 }
            else { return inputDbl / divisor }
        }
        else if (inputIndx > outputIndx)
        {
            diff = inputIndx - outputIndx
            if inputIndx == 3 { diff -= 1 }
            
            let multiplier = pow(60.0, Double(diff))
            
            if inputIndx == 3 { return (inputDbl * multiplier) * 24.0 }
            else { return inputDbl * multiplier }
        }
        
        return inputDbl
    }
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Section("Input Value and Type")
                {
                    TextField("Input", value: $input, format: .number)
                    Picker("Input Type", selection: $inputType)
                    {
                        ForEach(types, id: \.self)
                        {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Desired Output Value")
                {
                    Picker("Output Type", selection: $outputType)
                    {
                        ForEach(types, id: \.self)
                        {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output")
                {
                    Text("\(input) \(inputType) converts to \(output) \(outputType)")
                }
            }
            .navigationTitle("Time Conversion")
        }
    }
}

#Preview {
    ContentView()
}
