//
//  HabitCardView.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import SwiftUI
import Combine
struct HabitCardView: View {
    @State private var action = false
    
    let viewModel: HabitCardViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            NavigationLink(
                destination: viewModel.habitDetailView(),
                isActive: self.$action,
                label: {
                    EmptyView()
                }
            )
            
            Button(action: {
                self.action = true
            }, label: {
                
                HStack {
                    AsyncImage(url: URL(string: viewModel.icon ?? "https://placehold.co/400")) {image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 32, height: 32).clipped()
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text(viewModel.name)
                                .foregroundColor(Color.orange)
                            
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                        }.frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text("Registrado")
                                .foregroundColor(Color.orange)
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.value)
                                .foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                }
                .padding()
                .cornerRadius(4.0)
                
            })
            
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
            
        }.background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.orange, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
        
    }
}

#Preview("light") {
    NavigationView {
        
        List {
            HabitCardView(viewModel: HabitCardViewModel(id: 1,
                                                        icon: "https://via.placeholder.com/150",
                                                        date: "01/01/2021 00",
                                                        name: "Tocar guitarra",
                                                        label: "horas",
                                                        value: "2",
                                                        state: .green, habitPublisher: PassthroughSubject<Bool, Never>()))
            
            HabitCardView(viewModel: HabitCardViewModel(id: 1,
                                                        icon: "https://via.placeholder.com/150",
                                                        date: "01/01/2021 00:00:00",
                                                        name: "Tocar guitarra",
                                                        label: "horas",
                                                        value: "2",
                                                        state: .green, habitPublisher: PassthroughSubject<Bool, Never>()))
        }
          
        
    }
        
}
#Preview("Dark") {
    NavigationView {
        
        List {
            HabitCardView(viewModel: HabitCardViewModel(id: 1,
                                                        icon: "https://via.placeholder.com/150",
                                                        date: "01/01/2021 00:00:00",
                                                        name: "Tocar guitarra",
                                                        label: "horas",
                                                        value: "2",
                                                        state: .green, habitPublisher: PassthroughSubject<Bool, Never>()))
            
            HabitCardView(viewModel: HabitCardViewModel(id: 1,
                                                        icon: "https://via.placeholder.com/150",
                                                        date: "01/01/2021 00:00:00",
                                                        name: "Tocar guitarra",
                                                        label: "horas",
                                                        value: "2",
                                                        state: .green, habitPublisher: PassthroughSubject<Bool, Never>()))
        }.frame(maxWidth: .infinity)
            .navigationTitle("Teste")
        
    }
    
    .previewDevice("iPhone 11").preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

