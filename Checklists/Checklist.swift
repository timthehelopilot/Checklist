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
  
  required init?(coder aDecoder: NSCoder) {
    
    name = aDecoder.decodeObject(forKey: "Name") as! String
    
    items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
    
    super.init()
    
  }
  
  init(name: String) {
  
    self.name = name
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    
    aCoder.encode(name, forKey: "Name")
    aCoder.encode(items, forKey: "Items")    
  }
}
