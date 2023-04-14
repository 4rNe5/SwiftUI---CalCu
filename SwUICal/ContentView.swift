//
//  ContentView.swift
//  SwUICal
//
//  Created by Hyun on 2023/03/31.
//
// 추가할 개선점 : 3개 숫자 이상을 사용하는 사칙연산 구현, 연산자 우선순위

import SwiftUI

enum ButtonType: String { // 열거형 'ButtonType' 선언 (각 버튼의 타입과 표시할 문자열, 배경색, 전경색을 나타냄)
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

extension String {
    func addComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        if let number = Double(self) {
            return formatter.string(from: NSNumber(value: number)) ?? self
        }
        return self
    }
}

struct ContentView: View { // 뷰 선언 (계산기 앱의 UI를 구성, 버튼을 누를 때마다 totalNumber 변수에 값을 업데이트)
    
    @State private var totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var operatorType: ButtonType = .clear
    
    private let buttonData: [[ButtonType]] = [ // 2차원 buttonData 배열은 계산기 버튼의 레이아웃을 정의.
        [.clear, .opposite, .percent, .devide],
        [.seventh, .eighth, .nineth, .multiple],
        [.forth, .fifth, .sixth, .minus],
        [.first, .second, .third, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    Text(totalNumber.addComma())
                        .padding()
                        .font(.system(size: 73 ))
                        .foregroundColor(.white)
                }
                
                ForEach (buttonData, id: \.self) { line in
                    HStack {
                        ForEach(line, id: \.self) { item in
                            Button {
                                if totalNumber == "0" {
                                    
                                    if item == .clear {
                                        totalNumber = "0"
                                    } else if item == .plus ||
                                                item == .minus ||
                                                item == .multiple ||
                                                item == .devide {
                                        totalNumber = "Error"
                                    }
                                    else {
                                        totalNumber = item.ButtonDisplayName
                                    }
                                } else {
                                    if item == .clear {
                                        totalNumber = "0"
                                    } else if item == .plus {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .plus
                                        totalNumber = "0"
                                        
                                    } else if item == .multiple {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .multiple
                                        totalNumber = "0"
                                        
                                    }  else if item == .devide {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .devide
                                        totalNumber = "0"
                                        
                                    } else if item == .minus {
                                        tempNumber = Int(totalNumber) ?? 0
                                        operatorType = .minus
                                        totalNumber = "0"
                                        
                                    } else if item == .equal {
                                        
                                        if operatorType == .plus {
                                            totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)
                                        }else if operatorType == .multiple {
                                            totalNumber = String((Int(totalNumber) ?? 0) * tempNumber)
                                        }
                                        else if operatorType == .devide {
                                            if tempNumber == 0 || totalNumber == "0" {
                                                totalNumber = "Error"
                                            } else {
                                                totalNumber = String((Int(tempNumber) ) / (Int(totalNumber) ?? 0))
                                                //(Int(tempNumber) ?? 0)이 원본 코드.
                                            }
                                        }
                                        else if operatorType == .minus {
                                            totalNumber = String(tempNumber - (Int(totalNumber) ?? 0))
                                        }
                                        
                                    }
                                    else {
                                        totalNumber += item.ButtonDisplayName
                                    }
                                }
                            }label: {
                                Text (item.ButtonDisplayName)
                                    .bold()
                                    .frame(width: calculateButtonWidth(button: item), height: calculateButtonHeight(button: item))
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
    
    private func calculateButtonWidth(button buttonType: ButtonType ) -> CGFloat {
        switch buttonType {
        case .zero:
            return (UIScreen.main.bounds.width - 5*10) / 4 * 2
        default:
            return ((UIScreen.main.bounds.width - 5*10) / 4)
        }
    }
    
    private func calculateButtonHeight(button: ButtonType ) -> CGFloat {
            return ((UIScreen.main.bounds.width - 5*10) / 4)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
