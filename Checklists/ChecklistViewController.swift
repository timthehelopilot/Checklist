//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/16/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  
  var items: [ChecklistItem]
  
  required init?(coder aDecoder: NSCoder) {
    
    items = [ChecklistItem]()
    
    let row0item = ChecklistItem()
    row0item.text = "Walk the dog"
    row0item.checked = false
    items.append(row0item)
    
    let row1item = ChecklistItem()
    row1item.text = "Brush my teeth"
    row1item.checked = false
    items.append(row1item)
    
    let row2item = ChecklistItem()
    row2item.text = "Learn iOS development"
    row2item.checked = false
    items.append(row2item)
    
    let row3item = ChecklistItem()
    row3item.text = "Soccer practive"
    row3item.checked = false
    items.append(row3item)
    
    let row4item = ChecklistItem()
    row4item.text = "Eat ice cream"
    row4item.checked = false
    items.append(row4item)
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
    let item = items[indexPath.row]
    
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let cell = tableView.cellForRow(at: indexPath) {
      
      let item =  items[indexPath.row]
      
      item.toggleChecked()
      configureCheckmark(for: cell, with: item)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    items.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
    
  }
  
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    
    if item.checked {
      
      cell.accessoryType = .checkmark
      
    } else {
      
      cell.accessoryType = .none
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "AddItem" {
      
      let navigationController = segue.destination as! UINavigationController
      
      let controller = navigationController.topViewController as! AddItemViewController
      
      controller.delegate = self
    }
  }
  
  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
}

extension ChecklistViewController: AddItemViewControllerDelegate {
  
  func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
    
    controller.addItemTextField.resignFirstResponder()
    dismiss(animated: true, completion: nil)
  }
  
  func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
    
    let newRowIndex = items.count
    items.append(item)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    controller.addItemTextField.resignFirstResponder()
    dismiss(animated: true, completion: nil)
  }
}
