//: Playground - noun: a place where people can play

import UIKit


func makePascalTriangle(numOfRows : Int) -> ([[Int]]){
    
    if(numOfRows <= 1){
        return [[ 1 ]]
    }
    
    var before :[[Int]] = makePascalTriangle(numOfRows-1)
    let beforeLength = before.last!.count
    
    var thisTurn = [Int]()
    thisTurn.insert(1, atIndex: 0)
    for  i in 1..<beforeLength {
       let new = before.last![i] + before.last![i-1]
        thisTurn.insert(new, atIndex: i)
    }
    thisTurn.insert(1, atIndex: beforeLength)
    before.insert(thisTurn, atIndex: numOfRows-1)
    
    return before
    
}

let pascal :[[Int]] = makePascalTriangle(6)
print(pascal)
