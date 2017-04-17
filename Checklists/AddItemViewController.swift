//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/16/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
  
  func addItemViewControllerDidCancel(_ controller: AddItemViewController)
  func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
  
}

class AddItemViewController: UITableViewController {
  
  
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var addItemTextField: UITextField!
  
  weak var delegate: AddItemViewControllerDelegate?
  
  @IBAction func cancelButtonTapped() {
    
    delegate?.addItemViewControllerDidCancel(self)
  }
  
  @IBAction func doneButtonTapped() {
    
    let item = ChecklistItem()
    item.text = addItemTextField.text!
    item.checked = false
    
    delegate?.addItemViewController(self, didFinishAdding: item)
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    
    return nil
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    addItemTextField.becomeFirstResponder()
  }
}

extension AddItemViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText = addItemTextField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    
   doneBarButton.isEnabled = newText.length > 0
    
    return true
  }
  
}
