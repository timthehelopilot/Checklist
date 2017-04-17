//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/16/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import Foundation

class ChecklistItem {
  
  var text = ""
  var checked = false
  
  func toggleChecked() {
    
    checked = !checked
  }
}
