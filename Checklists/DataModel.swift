//
//  DataModel.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/19/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import Foundation


class DataModel {
  
  var lists = [Checklist]()
  
  var indexOfSelectedChecklist: Int {
    
    get {
     
      return UserDefaults.standard.integer(forKey: "ChecklistIndex")
    }
    
    set {
      
      UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
    }
  }
  
  func documentsDirectory() -> URL {
    
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    return paths[0]
  }
  
  func dataFilePath() -> URL {
    
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
  func saveChecklists() {
    
    let data = NSMutableData()
    
    let archiver = NSKeyedArchiver(forWritingWith: data)
    
    archiver.encode(lists, forKey: "Checklists")
    
    archiver.finishEncoding()
    data.write(to: dataFilePath(), atomically: true)
  }
  
  func loadChecklists() {
    
    let path = dataFilePath()
    
    if let data = try? Data(contentsOf: path) {
      
      let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
      
      lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
      
      unarchiver.finishDecoding()
    }
  }
  
  func registerDefaults() {
    
    let dictionary: [String: Any] = ["ChecklistIndex": -1]
    
    UserDefaults.standard.register(defaults: dictionary)
  }
  
  init() {
    
    loadChecklists()
    registerDefaults()
  }
  
}
