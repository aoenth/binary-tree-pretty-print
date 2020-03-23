import UIKit

class TreeNode {
  let value: Int
  var left: TreeNode?
  var right: TreeNode?
  init(_ value: Int) {
    self.value = value
  }
}

struct StringPoint {
  let x: Int
  let y: Int
  let val: String
}

func getWidth(node: TreeNode) -> Int {
  var width = 0
  if let leftNode = node.left {
    width += getWidth(node: leftNode)
  }
  if let rightNode = node.right {
    width += getWidth(node: rightNode)
  }
  
  width += String(node.value).count
  return width
}

func getStrings(x: Int, y: Int, node: TreeNode) -> [StringPoint] {
  var result: [StringPoint] = []
  let nodeValue = String(node.value)
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
      result.append(StringPoint(x: x - index - 1, y: y + index + 1, val: "/"))
      index += 1
    }
    result.append(contentsOf: getStrings(x: x + index + 1, y: y + index + 1, node: rightNode))
  }
  return result
}

func flatten(points: [StringPoint]) -> String {
  var result = ""
  for p in points {
    
  }
}

