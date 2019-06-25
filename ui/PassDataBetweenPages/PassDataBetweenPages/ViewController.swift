//
//  ViewController.swift
//  PassDataBetweenPages
//
//  Created by ArronStudio on 2019-06-24.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CanReceive {

    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToSecondPage(_ sender: Any) {
        performSegue(withIdentifier: "toPageTwo", sender: self)
    }
    
    @IBAction func changeColor(_ sender: Any) {
        view.backgroundColor = UIColor.green
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPageTwo" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.data = text1.text!
            secondVC.delegate = self
        }
    }
    
    func dataReceived(data: String) {
        label1.text = data
    }
    
}

