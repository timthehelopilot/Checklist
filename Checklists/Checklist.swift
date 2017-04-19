//
//  Checklist.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/18/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import UIKit

class Checklist: NSObject {

  var name = ""
  
  init(name: String) {
  
    self.name = name
    super.init()
  }
}
