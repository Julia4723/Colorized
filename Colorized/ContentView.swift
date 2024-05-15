//
//  ContentView.swift
//  Colorized
//
//  Created by user on 12.05.2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var redSlider = Double.random(in: 0...255).rounded()//Округляем до целых, потому что не используем дробные значения
    @State private var blueSlider = Double.random(in: 0...255).rounded()
    @State private var greenSlider = Double.random(in: 0...255).rounded()
    
    @State private var redTextField = ""
    @State private var blueTextField = ""
    @State private var greenTextField = ""
    
    @State private var isPresented = true
    @FocusState private var nameIsFocused: Bool
    
    
    var body: some View {
        VStack {
            Color(red:redSlider / 255, green: greenSlider / 255, blue: blueSlider / 255)
                .frame(width: 340, height: 200)
                .cornerRadius(10)
                .padding()
            
            HStack(spacing: 12){
                Text ("Red").frame(width: 60, alignment: .leading)
                ColorSliderView(value: $redSlider, textFieldValue: $redTextField)
                
                TextField("\(lround(redSlider))", text: $redTextField)
                    .bordered()
                    .focused($nameIsFocused)
                    .keyboardType(.numberPad)
                
            }
            .padding()
            
            HStack(spacing: 12){
                Text ("Blue").frame(width: 60, alignment: .leading)
                ColorSliderView(value: $blueSlider, textFieldValue: $blueTextField)
                
                TextField("\(lround(blueSlider))", text: $blueTextField)
                    .bordered()
                    .focused($nameIsFocused)
                    .keyboardType(.numberPad)
            }
            .padding()
            
            HStack(spacing: 12){
                Text ("Green").frame(width: 60, alignment: .leading)
                ColorSliderView(value: $greenSlider, textFieldValue: $greenTextField)
                
                TextField("\(lround(greenSlider))", text: $greenTextField)
                    .bordered()
                    .focused($nameIsFocused)
                    .keyboardType(.numberPad)
                    .submitLabel(.done)
                    .onSubmit {
                        print("Name entered: \($greenTextField)")
                    }
                
            }
            .padding()
            
            Button("Done", action: validate)
                .alert("Wrong format", isPresented: $isPresented, actions: {}) {
                    Text("Maximum number is 255")
                }
            Spacer()
        }
    }
    
    private func validate() {
        redSlider = Double(redTextField) ?? 0
        blueSlider = Double(blueTextField) ?? 0
        greenSlider = Double(greenTextField) ?? 0
        
        if redSlider >= 255 || blueSlider >= 255 || greenSlider >= 255 {
            redSlider = 0
            blueSlider = 0
            greenSlider = 0
            
            redTextField = "0"
            blueTextField = "0"
            greenTextField = "0"
            isPresented.toggle()
            return
        }
    }
}
      
        
struct ColorSliderView: View {
    @Binding var value: Double
    @Binding var textFieldValue: String

    
    var body: some View {
        HStack {
            Text(value.formatted())
                .font(.custom("", size: 17))
                .foregroundStyle(.blue)
            Slider(value: $value, in: 0...255, step: 1)

                .onChange(of: value) { newValue in
                    textFieldValue = "\(lround(newValue))"
                }
        }
    }
}
        
struct BorderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .frame(width: 60, alignment: .leading)
    }
}
        
extension TextField {
    func bordered() -> some View {
        modifier(BorderModifier())
    }
}
        

#Preview {
    ContentView()
}
  
        
