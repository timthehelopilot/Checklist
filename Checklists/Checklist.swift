//
//  Checklist.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/18/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {

  var name = ""
  var items = [ChecklistItem]()
  var iconName: String
  
  required init?(coder aDecoder: NSCoder) {
    
    name = aDecoder.decodeObject(forKey: "Name") as! String
    items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
    iconName = aDecoder.decodeObject(forKey: "IconName") as! String
    
    super.init()
  }
  
  convenience init(name: String) {
    
    self.init(name: name, iconName: "No Icon")
  }
  
  init(name: String, iconName: String) {
  
    self.name = name
    self.iconName = iconName
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    
    aCoder.encode(name, forKey: "Name")
    aCoder.encode(items, forKey: "Items")
    aCoder.encode(iconName, forKey: "IconName")
  }
  
  func countUncheckedItems() -> Int {
    
    return items.reduce(0) { count, item in count + (item.checked ? 0 : 1)}
  }
}
