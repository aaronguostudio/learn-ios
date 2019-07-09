//
//  ViewController.swift
//  Segue
//
//  Created by ArronStudio on 2019-06-23.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSecondPage", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondPage" {
            let dest = segue.destination as! SecondViewController
            dest.passText = textField.text!
        }
    }

}

