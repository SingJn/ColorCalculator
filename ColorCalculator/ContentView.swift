//
//  ContentView.swift
//  ColorCalculator
//
//  Created by 박상준 on 2023/08/16.
//

import SwiftUI

enum SelectedOperator: String {
    case plus = "+"
    case minus = "–"
    case muliply = "×"
    case divide = "÷"
    case equal = "="
}

struct ContentView: View {
    
    @State private var baseNumber: Double = 0
    @State private var calculateNumber: Double = 0
    @State private var selectedOperator: SelectedOperator = .equal
    @State private var lastSelectedOperator: SelectedOperator = .equal
    @State private var isSwitched: Bool = false
    @State private var isDecimalOn: Bool = false
    @State private var showDecimalMark: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            
            VStack {
                Spacer()
                
                resultNumView()
                
                HStack {
                    funcButton(clearOrAllClear())
                    funcButton("±")
                    funcButton("%")
                    operatorButton("÷")
                }
                
                HStack {
                    numButton("7")
                    numButton("8")
                    numButton("9")
                    operatorButton("×")
                }
                
                HStack {
                    numButton("4")
                    numButton("5")
                    numButton("6")
                    ///키보드 상의 하이픈(-)이 아니라 en dash(–)임
                    operatorButton("–")
                }
                
                HStack {
                    numButton("1")
                    numButton("2")
                    numButton("3")
                    operatorButton("+")
                }
                
                HStack {
                    numButton("0")
                    numButton(heartSelecter())
                    operatorButton("=")
                }
            }
            .padding()
        }
    }
    
    private func operatorPressed(_ name: String) {
        if(name == "=") {
            baseNumber = actionCalculate(lastSelectedOperator)
        } else {
            calculateNumber = 0
            isSwitched = false
        }
        selectedOperator = stringToSelectedOperator(name)
    }
    
    private func showHeart(_ name: String) {
        if(name != "♥︎") {
            actionNumButton(Double(name) ?? 0)
            showDecimalMark = false
        } else {
            showDecimalMark.toggle()
        }
    }
    
    private func heartSelecter() -> String {
        if showDecimalMark {
            return "♡"
        } else {
            return "♥︎"
        }
    }
    
    private func numberViewer() -> String{
        if(baseNumber <= 9999999999) {
            if(showDecimalMark) {
                return numFormatter(baseNumber) + "♥︎"
            }
            return numFormatter(baseNumber)
        }
        return "OverFlow"
    }
    
    private func actionCalculate(_ selectedOperator: SelectedOperator) -> Double {
        if !isSwitched {
            let tempNumber = calculateNumber
            calculateNumber = baseNumber
            baseNumber = tempNumber
            isSwitched = true
        }
        
        switch selectedOperator {
        case .divide: baseNumber = baseNumber / calculateNumber
        case .muliply: baseNumber = baseNumber * calculateNumber
        case .plus: baseNumber = baseNumber + calculateNumber
        case .minus: baseNumber = baseNumber - calculateNumber
        case .equal: baseNumber = baseNumber
        }
        return baseNumber
    }
    
    private func stringToSelectedOperator(_ string: String) -> SelectedOperator {
        switch string {
        case "÷": return .divide
        case "×": return .muliply
        case "–": return .minus
        case "+": return .plus
        case "=": return .equal
        default: return .equal
        }
    }
    
    private func clearOrAllClear() -> String {
        if(baseNumber == 0) {
            lastSelectedOperator = .equal
            return "AC"
        } else {
            lastSelectedOperator = .equal
            return "C"
        }
    }
    
    private func actionDividePersent() {
            baseNumber = baseNumber / 100
    }
    
    private func actionConvertPlusMinus() {
            baseNumber = baseNumber * -1
    }
    
    private func actionAllClear() {
        selectedOperator = .equal
        baseNumber = 0
    }
    
    private func actionNumButton(_ number: Double) {
        if selectedOperator != .equal {
            lastSelectedOperator = selectedOperator
            selectedOperator = .equal
            calculateNumber = baseNumber
            baseNumber = 0
        }
        if baseNumber == 0 {
            baseNumber = number
        } else {
            baseNumber = baseNumber*10 + number
        }
        if isDecimalOn {
            
        }
    }
    
    private func numFormatter(_ input: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: input) ?? ""
        
        return result
    }
    
    @ViewBuilder
    private func resultNumView() -> some View{
        HStack {
            Spacer()
            
            ///10자리 최대
            Text(numberViewer())
                .foregroundColor(.white)
                .font(.system(size: 120))
                .offset(y: 60)
                .minimumScaleFactor(0.3)
        }
        .padding(.trailing)
    }
    
    @ViewBuilder
    private func numButton(_ name: String) -> some View {
        
        Button {
            showHeart(name)
        } label: {
            switch name {
            case "0":
                Text(name)
                    .font(.system(size: 50))
                    .frame(width: 170, height: 80)
                    .offset(x: -48)
                    .background(.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(80)
                    .padding(5)
            default:
                Text(name)
                    .font(.system(size: 50))
                    .frame(width: 80, height: 80)
                    .offset(x: 0)
                    .background(.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(80)
                    .padding(5)
            }
        }
    }
    
    @ViewBuilder
    private func operatorButton(_ name: String) -> some View {
        Button {
            operatorPressed(name)
        } label: {
            if(name == selectedOperator.rawValue && name != "=") {
                Text(name)
                    .frame(width: 80, height: 80)
                    .font(.system(size: 60))
                    .baselineOffset(8)
                    .background(.white)
                    .foregroundColor(.orange)
                    .cornerRadius(80)
                    .padding(5)
            } else {
                Text(name)
                    .frame(width: 80, height: 80)
                    .font(.system(size: 60))
                    .baselineOffset(8)
                    .background(.orange)
                    .foregroundColor(.white)
                    .cornerRadius(80)
                    .padding(5)
            }
        }
    }
    
    @ViewBuilder
    private func funcButton(_ name: String) -> some View {
        switch name {
        case "AC", "C":
            Button {
                actionAllClear()
            } label: {
                Text(name)
                    .frame(width: 80, height: 80)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .background(.white.opacity(0.8))
                    .foregroundColor(.black)
                    .cornerRadius(80)
                    .padding(5)
                    .animation(nil, value: UUID())
            }
        case "±":
            Button {
                actionConvertPlusMinus()
            } label: {
                Text(name)
                    .frame(width: 80, height: 80)
                    .font(.system(size: 57))
                    .fontWeight(.regular)
                    .baselineOffset(8)
                    .background(.white.opacity(0.8))
                    .foregroundColor(.black)
                    .cornerRadius(80)
                    .padding(5)
            }
        default:
            Button {
                actionDividePersent()
            } label: {
                Text(name)
                    .frame(width: 80, height: 80)
                    .font(.system(size: 45))
                    .fontWeight(.bold)
                    .baselineOffset(0)
                    .background(.white.opacity(0.8))
                    .foregroundColor(.black)
                    .cornerRadius(80)
                    .padding(5)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
