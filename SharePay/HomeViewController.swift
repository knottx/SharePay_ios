//
//  ViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 16/11/2562 BE.
//  Copyright © 2562 knttx. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var addPPNo: UIButton!
    @IBOutlet var lbPPNo: UILabel!
    @IBOutlet var QRImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.lbPPNo.text = ""
    }
    
    @IBAction func didTapAddPPNo() {
        let alert = UIAlertController(title: "PromtPay", message: "Mobile, National ID", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.addTarget(alert, action: #selector(alert.textDidChangeInAlert), for: .editingChanged)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            // Should never happen
            guard let textField = alert.textFields?[0].text else { return }
            
            // Perform action
            self.lbPPNo.text = textField
        }
        
        ok.isEnabled = false
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapAddButton() {
        // Safe Present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFriendViewController") as? AddFriendViewController
        {
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true, completion: nil)
        }
    }
}

extension UIAlertController {

    func isValidNumber(_ number: String) -> Bool {
        return (number.count == 10 || number.count == 13) && number.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
    }

    @objc func textDidChangeInAlert() {
        if let number = textFields?[0].text,
            let action = actions.last {
            action.isEnabled = isValidNumber(number)
        }
    }
}
