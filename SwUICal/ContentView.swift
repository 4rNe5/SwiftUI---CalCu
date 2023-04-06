//
//  ContentView.swift
//  SwUICal
//
//  Created by Hyun on 2023/03/31.
//

import SwiftUI

enum ButtonType: String {
    case first, second, third, forth, fifth, sixth, seventh, eighth, nineth, zero
    case dot, equal, plus, minus, multiple, devide
    case percent, opposite, clear
    
    var ButtonDisplayName: String {
        switch self{
        case .first :
            return "1"
        case .second :
            return "2"
        case .third :
            return "3"
        case .forth :
            return "4"
        case .fifth :
            return "5"
        case .sixth :
            return "6"
        case .seventh :
            return "7"
        case .eighth :
            return "8"
        case .nineth :
            return "9"
        case .zero :
            return "0"
        case .dot :
            return "."
        case .equal :
            return "="
        case .plus :
            return "+"
        case .minus :
            return "-"
        case .multiple :
            return "×"
        case .devide :
            return "÷"
        case .percent :
            return "%"
        case .opposite :
            return "+/-"
        case .clear :
            return "C"
        }
    }
    
    var backgroundColor: Color {
        switch self {
            
        case .first, .second, .third, .forth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, .dot:
            return Color("NumberButton")
        case .equal, .plus, .minus, .multiple, .devide:
            return Color.orange
        case .percent, .opposite, .clear:
            return Color.gray
        }
    }
    
    var forgroundColor: Color {
        switch self {
            
        case .first, .second, .third, .forth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, .dot, .equal, .plus, .minus, .multiple, .devide:
            return Color.white
        case .percent, .opposite, .clear:
            return Color.black
        }
    }
}
    
    struct ContentView: View {
        
        @State private var totalNumber: String = "0"
        
        private let buttonData: [[ButtonType]] = [
            [.clear, .opposite, .percent, .devide],
            [.seventh, .eighth, .nineth, .multiple],
            [.forth, .fifth, .sixth, .minus],
            [.first, .second, .third, .plus],
            [.zero, .zero, .dot, .equal]
        ]
        
        var body: some View {
            ZStack{
                Color.black.ignoresSafeArea()
                
                VStack{
                    Spacer()
                    
                    HStack{
                        Spacer()
                        Text(totalNumber)
                            .padding()
                            .font(.system(size: 73 ))
                            .foregroundColor(.white)
                    }
                    
                    ForEach (buttonData, id: \.self) { line in
                        HStack {
                            ForEach(line, id: \.self) { item in
                                Button {
                                    if totalNumber == "0" {
                                        totalNumber = "7"
                                    } else {
                                        totalNumber += "7"
                                    }
                                }label: {
                                    Text (item.ButtonDisplayName)
                                        .frame(width: 80,
                                               height: 80)
                                        .background(item.backgroundColor)
                                        .cornerRadius (40)
                                        .foregroundColor (item.forgroundColor)
                                        .font (.system(size: 33))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View{
            ContentView()
        }
    }
