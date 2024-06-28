//
//  CustomTextField.swift
//  Habit
//
//  Created by Jamerson Macedo on 28/06/24.
//

import SwiftUI
struct CustomTextField : TextFieldStyle{
    public func _body(configuration:TextField<Self._Label>) ->some View{
        configuration
            .padding(.horizontal,8)
            .padding(.vertical,16)
            .overlay(RoundedRectangle(cornerRadius: 8.0)
            .stroke(Color.orange, lineWidth: 0.8))
    }
    
    
}
