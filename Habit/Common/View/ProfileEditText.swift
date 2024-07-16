//
//  ProfileEditText.swift
//  Habit
//
//  Created by Jamerson Macedo on 16/07/24.
//
import SwiftUI
import Foundation
struct ProfileEditText:View{
    var placeholder:String = ""

    var mask : String? = nil
   
    var keyboard:UIKeyboardType = .default
    var autocapitalization : UITextAutocapitalizationType = .none
   
    @Binding var text :String// tem que ser bind pq ele vai ser chamado por ouyto
    var body: some View{
        VStack{
                TextField(placeholder,text: $text).foregroundStyle(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocapitalization(autocapitalization)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: text){ value in
                        if let mask = mask{
                            Mask.mask(mask:mask, value:value, text:&text)
                        }
                        
                    }
            }.padding(.bottom,10)
            
    }
        
    
}



#Preview("Light") {
EditTextView(placeholder:"E-mail", text: .constant(""))
    .preferredColorScheme(.light).padding()
}

#Preview("Dark") {
EditTextView(placeholder:"E-mail", text: .constant(""))
    .preferredColorScheme(.dark).padding()
}
