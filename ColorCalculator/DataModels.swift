//
//  ViewModel.swift
//  ColorCalculator
//
//  Created by 박상준 on 2023/08/23.
//

import SwiftUI

enum SelectedOperator: String {
    case plus = "+"
    case minus = "–"
    case muliply = "×"
    case divide = "÷"
    case equal = "="
}

class CalculatorDataStorage: ObservableObject {
    @Published var baseNumber: Double = 0
    @Published var calculateNumber: Double = 0
    @Published var selectedOperator: SelectedOperator = .equal
    @Published var lastSelectedOperator: SelectedOperator = .equal
    @Published var isSwitched: Bool = false
    @Published var showDecimalMark: Bool = false
}

extension CalculatorDataStorage {
    public func operatorPressed(_ name: String) {
        if(name == "=") {
            baseNumber = actionCalculate(lastSelectedOperator)
        } else {
            calculateNumber = 0
            isSwitched = false
        }
        selectedOperator = stringToSelectedOperator(name)
    }
    
    public func showHeart(_ name: String) {
        if(name != "♥︎") {
            actionNumButton(Double(name) ?? 0)
            showDecimalMark = false
        } else {
            showDecimalMark.toggle()
        }
    }
    
    public func heartSelecter() -> String {
        if showDecimalMark {
            return "♡"
        } else {
            return "♥︎"
        }
    }
    
    public func numberViewer() -> String{
        if(baseNumber > 9999999999) {
            return "OverFlow!"
        } else {
            if(showDecimalMark) {
                return numFormatter(baseNumber) + "♥︎"
            }
            return numFormatter(baseNumber)
        }
    }
    
    public func actionCalculate(_ selectedOperator: SelectedOperator) -> Double {
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
    
    public func stringToSelectedOperator(_ string: String) -> SelectedOperator {
        switch string {
        case "÷": return .divide
        case "×": return .muliply
        case "–": return .minus
        case "+": return .plus
        case "=": return .equal
        default: return .equal
        }
    }
    
    public func actionDividePersent() {
            baseNumber = baseNumber / 100
    }
    
    public func actionConvertPlusMinus() {
            baseNumber = baseNumber * -1
    }
    
    public func actionAllClear() {
        selectedOperator = .equal
        baseNumber = 0
    }
    
    public func actionNumButton(_ number: Double) {
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
    }
    
    public func numFormatter(_ input: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: input) ?? ""
        
        return result
    }
}
