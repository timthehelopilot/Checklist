//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Timothy Barrett on 4/19/17.
//  Copyright © 2017 Timothy Barrett. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
  
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
  
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
  
}

class ListDetailViewController: UITableViewController {
  
  @IBOutlet weak var checklistTextField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: ListDetailViewControllerDelegate?
  
  var checklistToEdit: Checklist?
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    checklistTextField.becomeFirstResponder()
    
  }

    override func viewDidLoad() {
        super.viewDidLoad()

      if let checklist = checklistToEdit {
        
        title = "Edit Checklist"
        checklistTextField.text = checklist.name
        doneBarButton.isEnabled = true
      }
    }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    
    return nil
  }
  
  @IBAction func cancel() {
    
    checklistTextField.resignFirstResponder()
    delegate?.listDetailViewControllerDidCancel(self)
  }
  
  @IBAction func Done() {
    
    if let checklist = checklistToEdit {
      
      checklist.name = checklistTextField.text!
      delegate?.listDetailViewController(self, didFinishEditing: checklist)
      
    } else {
      
      let checklist = Checklist(name: checklistTextField.text!)
      delegate?.listDetailViewController(self, didFinishAdding: checklist)
    }
    
    checklistTextField.resignFirstResponder()
  }
}

extension ListDetailViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText = checklistTextField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    
    doneBarButton.isEnabled = newText.length > 0
    
    return true
  }
  
  
}
