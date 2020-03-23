//: [Previous](@previous)

/*
 Borrowed from https://gist.github.com/khanov/4f1472b5ae001da817db
 */

import Foundation

class Node {
  var left, right: Node?
  var value: String
  
  init(_ value: String = "") {
    self.value = value
  }
  
  func toString() -> String {
    return buildTreeString(isTail: true)
  }
  
  private func buildTreeString(prefix: String = "", isTail: Bool) -> String {
    var result = ""
    
    if right != nil {
      let newPrefix = prefix + (isTail ? "│   " : "    ")
      result += right!.buildTreeString(prefix: newPrefix, isTail: false)
    }
    
    result += prefix + (isTail ? "└── " : "┌── ") + value + "\n"
    
    if left != nil {
      let newPrefix = prefix + (isTail ? "    " : "│   ")
      result += left!.buildTreeString(prefix: newPrefix, isTail: true)
    }
    
    return result
  }
  
}

let node1 = Node("1")
let node2 = Node("2")
let node3 = Node("3")
let node4 = Node("4")
let node5 = Node("5")
let node6 = Node("6")
let node7 = Node("7")

node2.left = node1
node2.right = node3
node4.left = node2
node4.right = node6
node6.left = node5
node6.right = node7

print(node4.toString())

//: [Next](@next)
