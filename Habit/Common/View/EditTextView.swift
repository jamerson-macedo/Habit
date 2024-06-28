//
//  EditTextView.swift
//  Habit
//
//  Created by Jamerson Macedo on 28/06/24.
//

import SwiftUI
struct EditTextView :View{
    
    var placeholder:String = ""
    var error :String? = nil
    var failure : Bool? = nil
    var keyboard:UIKeyboardType = .default
    @Binding var text :String// tem que ser bind pq ele vai ser chamado por ouyto
    var body: some View{
        VStack{
            TextField(placeholder,text: $text).foregroundStyle(Color("textColor"))
                .keyboardType(keyboard)
                .textFieldStyle(CustomTextField())
                
            // otexto vai aparecer se n for nulo e nem vazio
            if let error = error, !text.isEmpty, failure == true{
                Text(error).foregroundStyle(Color.red)
            }
        }.padding(.bottom,10)
        
    }
}


#Preview("Light") {
    EditTextView(placeholder:"E-mail", error: "Campo invalido", failure: true, text: .constant(""))
        .preferredColorScheme(.light).padding()
}

#Preview("Dark") {
    EditTextView(placeholder:"E-mail", error: "Campo invalido", failure: true, text: .constant(""))
        .preferredColorScheme(.dark).padding()
}

