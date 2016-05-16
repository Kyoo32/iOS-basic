//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var c = "l"

var view :UIView
view = UIView.init(frame:CGRectMake(0, 0, 300, 400))
view.backgroundColor = UIColor.redColor()

var q = 2

var total = 0;
var array = [Int]()
for member in 0...10{
    array.append(member)
    total += member
}

array

var cat = "😳"

print(cat)



print(Int.max)


infix operator ^^ { }
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}


func hammingWeight(input :Int)->(bitStirng:String, numberOneCount :Int){
    var maxDivider = 0
    var resultBitString = ""
    var count = 0
    
    for divider in 0...31 {
        if(input / divider == 1){
            maxDivider = divider
            break
        }
    }
    
    var quotient = 0
    var dividend = input
    var reminder = 0
    
    for divisor in (0...maxDivider).reverse(){
        
        quotient = input / 2^^divisor
        if(quotient == 1) {count + 1}
        resultBitString += String(quotient)
        
        reminder = dividend - quotient * (2^^divisor)
        dividend = reminder
    }
    
    return(resultBitString, count)
}

hammingWeight(11)














