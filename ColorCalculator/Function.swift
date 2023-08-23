//
//  File.swift
//  ColorCalculator
//
//  Created by 박상준 on 2023/08/22.
//
import SwiftUI

extension CalculatorViewModel {
    public func operatorPressed(_ name: CLOperator) {
        if(name == .equal) {
            baseNumber = actionCalculate(lastSelectedOperator)
        } else {
            calculateNumber = 0
            isSwitched = false
        }
        selectedOperator = name
    }
    
    public func showHeart(_ name: CLNumber) {
        if(name != .fillHeart) {
            showDecimalMark = false
        } else {
            showDecimalMark.toggle()
        }
    }
    
    public func heartSelecter() -> CLNumber {
        if showDecimalMark {
            return .emptyHeart
        } else {
            return .fillHeart
        }
    }
    
    public func numberViewer() -> String {
        if(baseNumber > 9999999999) {
            return "OverFlow!"
        } else {
            if(showDecimalMark) {
                return numFormatter(baseNumber) + "♥︎"
            }
            return numFormatter(baseNumber)
        }
    }
    
    public func actionCalculate(_ selectedOperator: CLOperator) -> Double {
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
    
    public func actionNumButton(_ pressedNumber: CLNumber) {
        let number = Double(pressedNumber.rawValue) ?? 0
        
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

