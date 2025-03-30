import Foundation

//struct Stack<Element> {
//    var items: [Element] = []
//    mutating func push(_ item: Element) {
//        items.append(item)
//    }
//    mutating func pop() -> Element? {
//        items.removeLast()
//    }
//    
//    
//}
//
//
//extension Stack {
//    var topElement: Element? {
//        return !items.isEmpty ? items[items.count - 1] : nil
//    }
//}
//var test = Stack<Int>()
//test.push(2)
//test.topElement
//
//func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

protocol ItemStoring {
    associatedtype Item
    var items: [Item] { get set }
    mutating func add(item: Item)
}

protocol Test {
    associatedtype Item
    
    mutating func add(item: Item)
}

extension Test where Item == Int {
    mutating func printHelllo() {
        print("hello world")
    }
}

struct NameDatabase: ItemStoring {
    mutating func add(item: String) {
        items.append(item)
    }
    
    var items = [String]()
    
    subscript(i: Int) -> String {
        get {
            return items[i]
        }
        set {
            items[i] = newValue
        }
    }
}

var names = NameDatabase()
names.add(item: "Alice")
names.add(item: "Bob")
names[0] = "Ahmed"
print(names[0]) // Output: ["Alice", "Bob"]

extension Collection {
    
}
