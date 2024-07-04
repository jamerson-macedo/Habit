//
//  GenderSelectorView.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import SwiftUI

struct GenderSelectorView: View {
    let title :String
    let genders:[Gender]
    @Binding var selectedgender : Gender?
    var body: some View {
        Form{
            Section(header: Text(title)){
                List(genders,id: \.id){ item in
                    HStack{
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName: "checkmark").foregroundStyle(selectedgender == item ? .orange : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedgender == item){
                            selectedgender = item
                        }
                    }
                   
                    
                }
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

#Preview {
    GenderSelectorView(title: "GENERO", genders: Gender.allCases, selectedgender: .constant(.male))
}
