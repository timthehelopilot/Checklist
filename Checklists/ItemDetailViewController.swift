//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/16/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
  
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
  
}

class ItemDetailViewController: UITableViewController {
  
  
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var addItemTextField: UITextField!
  
  weak var delegate: ItemDetailViewControllerDelegate?
  
  var itemToEdit: ChecklistItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let item = itemToEdit {
      
      title = "Edit Item"
      addItemTextField.text = item.text
      doneBarButton.isEnabled = true
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    addItemTextField.becomeFirstResponder()
  }

  
  @IBAction func cancelButtonTapped() {
    
    delegate?.itemDetailViewControllerDidCancel(self)
  }
  
  @IBAction func doneButtonTapped() {
    
    if let item = itemToEdit {
      
      item.text = addItemTextField.text!
      
      delegate?.itemDetailViewController(self, didFinishEditing: item)
      
    } else {
      
      let item = ChecklistItem()
      item.text = addItemTextField.text!
      item.checked = false
      
      delegate?.itemDetailViewController(self, didFinishAdding: item)
    }
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    
    return nil
  }
  
}

extension ItemDetailViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText = addItemTextField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    
   doneBarButton.isEnabled = newText.length > 0
    
    return true
  }
  
}
