//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/16/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, NSCoding {
  
  var text = ""
  var checked = false
  var dueDate = Date()
  var shouldRemind = false
  var itemID: Int

  required init?(coder aDecoder: NSCoder) {
    
    text = aDecoder.decodeObject(forKey: "Text") as! String
    checked = aDecoder.decodeBool(forKey: "Checked")
    dueDate = aDecoder.decodeObject(forKey: "Duedate") as! Date
    shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
    itemID = aDecoder.decodeInteger(forKey: "ItemID")
    
    super.init()
  }
  
  override init() {
    
    itemID = DataModel.nextChecklistItemID()
    super.init()
  }
  
  deinit {
    
    removeNotification()
  }
  
  func toggleChecked() {
    
    checked = !checked
  }
  
  func scheduleNotification() {
    
    removeNotification()
    
    if shouldRemind && dueDate > Date() {
      
      let content = UNMutableNotificationContent()
      content.title = "Reminder"
      content.body = text
      content.sound = UNNotificationSound.default()
      
      let calender = Calendar(identifier: .gregorian)
      let components = calender.dateComponents([.month, .day, .hour, .minute], from: dueDate)
      let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
      let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
      let center = UNUserNotificationCenter.current()
      
      center.add(request)
    }
  }
  
  func removeNotification() {
    
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
  }
  
  func encode(with aCoder: NSCoder) {
    
    aCoder.encode(text, forKey: "Text")
    aCoder.encode(checked, forKey: "Checked")
    aCoder.encode(dueDate, forKey: "DueDate")
    aCoder.encode(shouldRemind, forKey: "ShouldRemind")
    aCoder.encode(itemID, forKey: "ItemID")
  }
}
