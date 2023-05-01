//
//  GridView.swift
//  ClockWatch Watch App
//
//  Created by Jamal Aartsen on 01/05/2023.
//

import SwiftUI

struct GridView: View {
    
    // MARK: - PROPERTIES
    let grid = GridAlgorithm()
    @ObservedObject var clockTimer = ClockTimer()
    
    // MARK: - BODY
    var body: some View {
        ZStack {
//            Color.gray
//                .opacity(0.1)
//                .cornerRadius(20)
//                .ignoresSafeArea()
            
            VStack {
                
//                HStack {
//                    ForEach(0..<10) { index in
//                        if let currentTime = clockTimer.currentTime {
//                            Text("\(currentTime[index])")
//                                .frame(width: 13)
//                                .font(.system(size: 12))
//                                .padding(.bottom, 5)
//                        }
//                    }
//                }

                Spacer()
                
                ForEach(0..<grid.array[0].count) { column in
                    // HStack places content horizontally
                    HStack {
                        // Iterate over each row index
                        ForEach(0..<grid.array.count) { row in
                            // Retrieve the number from the gridArray at the current row and column
                            let number = grid.array[row][column]
                            // Determine the text color for the current cell
                            let isTimeNumber = self.isTimeNumber(row: row, column: column)
                            // Determine if the current cell's value is a birthday number
                            let isBirthdayNumber = isBirthdayNumber(row: row, column: column)
                            
                            Text("\(number)")
                                .font(.system(size: 12))
                                .foregroundColor(isTimeNumber ? .white : isBirthdayNumber ? .blue : .white)
                                .scaleEffect(isTimeNumber ? 1.2 : 0.8)
                                .opacity(isTimeNumber ? 1 : 0.5)
                                .frame(width: 13)
                            //                            .animation(.easeInOut(duration: 0.5))
                        } //: LOOP
                    } //: HSTACK
                } //: LOOP
                
                Spacer()
            } //: VSTACK
        } //: ZSTACK
    }
}

// MARK: - FUNCTIONS
extension GridView {
   
    private func isTimeNumber(row: Int, column: Int) -> Bool {
        return grid.array[row][column] == clockTimer.currentTime?[row]
    }
    
    private func isBirthdayNumber(row: Int, column: Int) -> Bool {
        let fixedValues = grid.fixedvalues
        let fixedValuesWithoutLastTwo = fixedValues.dropLast(2)
        
        if row < fixedValuesWithoutLastTwo.count {
            return grid.array[row][column] == fixedValuesWithoutLastTwo[row]
        } else {
            return false
        }
    }
}

// MARK: - PREVIEW
struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
