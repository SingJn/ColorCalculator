//
//  ViewModel.swift
//  ColorCalculator
//
//  Created by 박상준 on 2023/08/23.
//

import SwiftUI

enum CLFunction: String {
    case allClear = "AC"
    case plusMinus = "±"
    case persent = "%"
}

enum CLNumber: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    
    case fillHeart = "♥︎"
    case emptyHeart = "♡"
}

enum CLOperator: String {
    case plus = "+"
    case minus = "–"
    case muliply = "×"
    case divide = "÷"
    case equal = "="
}

class CalculatorViewModel: ObservableObject {
    @Published var baseNumber: Double = 0
    @Published var calculateNumber: Double = 0
    @Published var selectedOperator: CLOperator = .equal
    @Published var lastSelectedOperator: CLOperator = .equal
    @Published var isSwitched: Bool = false
    @Published var showDecimalMark: Bool = false
}

