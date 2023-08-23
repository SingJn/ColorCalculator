//
//  ContentView.swift
//  ColorCalculator
//
//  Created by 박상준 on 2023/08/16.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var calculatorVM = CalculatorViewModel()
    
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
                    funcButton(.allClear)
                    funcButton(.plusMinus)
                    funcButton(.persent)
                    operatorButton(.divide)
                }
                
                HStack {
                    numButton(.seven)
                    numButton(.eight)
                    numButton(.nine)
                    operatorButton(.muliply)
                }
                
                HStack {
                    numButton(.four)
                    numButton(.five)
                    numButton(.six)
                    operatorButton(.minus)
                }
                
                HStack {
                    numButton(.one)
                    numButton(.two)
                    numButton(.three)
                    operatorButton(.plus)
                }
                
                HStack {
                    numButton(.zero)
                    numButton(.fillHeart)
                    operatorButton(.equal)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func resultNumView() -> some View {
        HStack {
            Spacer()
            
            Text(calculatorVM.numberViewer())
                .foregroundColor(.white)
                .font(.system(size: 120))
                .offset(y: 60)
                .minimumScaleFactor(0.3)
        }
        .padding(.trailing)
    }
    
    @ViewBuilder
    private func numButton(_ name: CLNumber) -> some View {
        switch name {
        case .fillHeart:
            Button {
                calculatorVM.showHeart(name)
            } label: {
                Text(calculatorVM.heartSelecter().rawValue)
                    .font(.system(size: 50))
                    .frame(width: 80, height: 80)
                    .background(.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(80)
                    .padding(5)
            }
        case .zero:
            Button {
                calculatorVM.actionNumButton(name)
            } label: {
                Text(name.rawValue)
                    .font(.system(size: 50))
                    .frame(width: 170, height: 80)
                    .offset(x: -48)
                    .background(.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(80)
                    .padding(5)
            }
        default:
            Button {
                calculatorVM.actionNumButton(name)
            } label: {
                Text(name.rawValue)
                    .font(.system(size: 50))
                    .frame(width: 80, height: 80)
                    .background(.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(80)
                    .padding(5)
            }
        }
        
    }
    
    @ViewBuilder
    private func operatorButton(_ name: CLOperator) -> some View {
        Button {
            calculatorVM.operatorPressed(name)
        } label: {
            if(name == calculatorVM.selectedOperator && name != .equal) {
                Text(name.rawValue)
                    .frame(width: 80, height: 80)
                    .font(.system(size: 60))
                    .baselineOffset(8)
                    .background(.white)
                    .foregroundColor(.orange)
                    .cornerRadius(80)
                    .padding(5)
            } else {
                Text(name.rawValue)
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
    private func funcButton(_ name: CLFunction) -> some View {
        switch name {
        case .allClear:
            Button {
                calculatorVM.actionAllClear()
            } label: {
                Text(name.rawValue)
                    .frame(width: 80, height: 80)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .background(.white.opacity(0.8))
                    .foregroundColor(.black)
                    .cornerRadius(80)
                    .padding(5)
                    .animation(nil, value: UUID())
            }
        case .plusMinus:
            Button {
                calculatorVM.actionConvertPlusMinus()
            } label: {
                Text(name.rawValue)
                    .frame(width: 80, height: 80)
                    .font(.system(size: 57))
                    .fontWeight(.regular)
                    .baselineOffset(8)
                    .background(.white.opacity(0.8))
                    .foregroundColor(.black)
                    .cornerRadius(80)
                    .padding(5)
            }
        case .persent:
            Button {
                calculatorVM.actionDividePersent()
            } label: {
                Text(name.rawValue)
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
