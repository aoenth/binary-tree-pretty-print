import UIKit

class TreeNode<T: CustomStringConvertible> {
  let value: T
  var left: TreeNode?
  var right: TreeNode?
  init(_ value: T) {
    self.value = value
  }
}

struct StringPoint {
  let x: Int
  let y: Int
  let val: String
}

func prettyPrint<T: CustomStringConvertible>(root: TreeNode<T>) -> String {
  let rootWidth = (getWidth(node: root) + 1)/2
  let strings = getStrings(x: rootWidth, y: 0, node: root)
  var lines = [Int: [StringPoint]]()
  for stringPoint in strings {
    if lines[stringPoint.y] != nil {
      lines[stringPoint.y]!.append(stringPoint)
    } else {
      lines[stringPoint.y] = [stringPoint]
    }
  }
  
  var result = ""
  for line in lines.keys.sorted() {
    result += flatten(points: lines[line]!) + "\n"
  }
  return result
}

func getWidth<T: CustomStringConvertible>(node: TreeNode<T>) -> Int {
  var width = 0
  if let leftNode = node.left {
    width += getWidth(node: leftNode)
  }
  if let rightNode = node.right {
    width += getWidth(node: rightNode)
  }
  
  width += node.value.description.count
  return width
}

func getStrings<T: CustomStringConvertible>(x: Int, y: Int, node: TreeNode<T>) -> [StringPoint] {
  var result: [StringPoint] = []
  let nodeValue = node.value.description
  let new = StringPoint(x: x - nodeValue.count / 2, y: y, val: nodeValue)
  result.append(new)
  
  if let leftNode = node.left {
    let width = getWidth(node: leftNode)
    var index = 0
    while index < (width + 1)/2 {
      result.append(StringPoint(x: x - index - 1, y: y + index + 1, val: "/"))
      index += 1
    }
    result.append(contentsOf: getStrings(x: x - index - 1, y: y + index + 1, node: leftNode))
  }
  
  if let rightNode = node.right {
    let width = getWidth(node: rightNode)
    var index = 0
    while index < (width + 1)/2 {
      result.append(StringPoint(x: x + index + 1, y: y + index + 1, val: "\\"))
      index += 1
    }
    result.append(contentsOf: getStrings(x: x + index + 1, y: y + index + 1, node: rightNode))
  }
  return result
}

func flatten(points: [StringPoint]) -> String {
  var result = ""
  var x = 0
  for p in points {
    let count = max(p.x - x, 0)
    result += String(repeating: " ", count: count)
    result += p.val
    x = result.count
  }
  return result
}

let node1 = TreeNode(1)
let node2 = TreeNode(2)
let node3 = TreeNode(3)
let node4 = TreeNode(4)
let node5 = TreeNode(5)
let node6 = TreeNode(6)
let node7 = TreeNode(7)

node2.left = node1
node2.right = node3
node4.left = node2
//node4.right = node6
node6.left = node5
node6.right = node7

print(prettyPrint(root: node4))
