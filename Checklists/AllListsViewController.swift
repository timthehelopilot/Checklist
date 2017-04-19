//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/18/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
  
  var lists: [Checklist]
  
  required init?(coder aDecoder: NSCoder) {
    
    lists = [Checklist]()
    
    super.init(coder: aDecoder)
    
    var list = Checklist(name: "Birthdays")
    lists.append(list)
    
    list = Checklist(name: "Groceries")
    lists.append(list)
    
    list = Checklist(name: "Cool Apps")
    lists.append(list)
    
    list = Checklist(name: "To Do")
    lists.append(list)
  }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return lists.count
    }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let checklist = lists[indexPath.row]
    performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    
  }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = makeCell(for: tableView)
      
      let checklist = lists[indexPath.row]
      cell.textLabel?.text = checklist.name
      cell.accessoryType = .detailDisclosureButton
      
      return cell
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "ShowChecklist" {
      
      let controller = segue.destination as! ChecklistViewController
      controller.checklist = sender as! Checklist
    }
  }

  func makeCell(for tableview: UITableView) -> UITableViewCell {
    
    let cellIdentifer = "Cell"
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) {
      
      return cell
    } else {
      
      return UITableViewCell(style: .default, reuseIdentifier: cellIdentifer)
    }
  }
}
