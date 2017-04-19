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
    
    for list in lists {
      
      let item = ChecklistItem()
      item.text = "Item for \(list.name)"
      list.items.append(item)
      
    }
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
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    lists.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    
    let navigationController = storyboard?.instantiateViewController(withIdentifier: "ListDetailNavigationController") as! UINavigationController
    
    let controller = navigationController.topViewController as! ListDetailViewController
    
    controller.delegate = self
    
    let checklist = lists[indexPath.row]
    controller.checklistToEdit = checklist
    
    present(navigationController, animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "ShowChecklist" {
      
      let controller = segue.destination as! ChecklistViewController
      controller.checklist = sender as! Checklist
    } else if segue.identifier == "AddChecklist" {
      
      let navigationController = segue.destination as! UINavigationController
      
      let controller = navigationController.topViewController as! ListDetailViewController
      
      controller.delegate = self
      
      controller.checklistToEdit = nil
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

extension AllListsViewController: ListDetailViewControllerDelegate {
  
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
    
    controller.checklistTextField.resignFirstResponder()
    dismiss(animated: true, completion: nil)
    
  }
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
    
    let newRowIndex = lists.count
    lists.append(checklist)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    controller.checklistTextField.resignFirstResponder()
    dismiss(animated: true, completion: nil)
  }
  
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
    
    if let index = lists.index(of: checklist) {
      
      let indexPath = IndexPath(row: index , section: 0)
      
      if let cell = tableView.cellForRow(at: indexPath) {
        
        cell.textLabel?.text = checklist.name
      }
    }
    
    controller.checklistTextField.resignFirstResponder()
    dismiss(animated: true, completion: nil)
  }
}
