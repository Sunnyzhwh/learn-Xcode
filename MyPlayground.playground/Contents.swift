//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

var str = "lodved"
let raw = str.index(before: str.endIndex)
str[str.index(str.startIndex, offsetBy: 2)]
let limited = str.index(str.endIndex, offsetBy: -1)
str[str.index(str.startIndex, offsetBy: 3, limitedBy: limited)!]
str[str.index(after: str.startIndex)]
str[str.index(after: str.index(str.startIndex, offsetBy: 2))]
let range = str.startIndex ..< str.index(after: str.index(str.startIndex ,offsetBy: 2))
str[range]
let shuffledString = str.shuffled()
print(str[raw])
print(str.first!)
print(str)
print(shuffledString.last!)
str = str.replacingOccurrences(of: "d", with: "")
print(str)
str[str.index(before: str.endIndex)]
//创建实例 instance
class test1 {
    var a = 100
    func output() {
        print(a)
    }
}
var a1 = test1()
a1.output()
//类型方法
class test2 {
    var b = 200
    static func output() {
        print("201")
    }
}
test2.output()
struct test3 {
    var c = 100
    func output() {
        print(c)
    }
}
let c1 = test3()
c1.output()
struct test4 {
    var d = 100
    static func output() {
        print("--")
    }
}
let d1 = test4()
d1.d
test4.output()
func changeSign(double: Double) -> Double{
    return -double
}
enum OP {
    case constant(Double)
    case unaryOperation((Double) -> Double)
}
var operation:Dictionary = ["𝝿": OP.constant(Double.pi),"±": OP.unaryOperation(changeSign)]
let tuple = [("name","img","msg"), ("named","imgd","msgs")]
tuple[1].1


var swit = false
swit = true
func atest(){
    if swit { return }
    print("\(swit)")
}
atest()
swit = false
atest()
