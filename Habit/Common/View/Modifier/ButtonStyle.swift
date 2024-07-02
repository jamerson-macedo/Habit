//
//  ButtonStyle.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import Foundation
import SwiftUI
struct ButtonStyle : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.vertical,14)
            .padding(.horizontal,16)
            .font(.title3).bold()
            .background(Color.orange)
            .foregroundStyle(Color.white)
            .cornerRadius(4.0)
    }
}
