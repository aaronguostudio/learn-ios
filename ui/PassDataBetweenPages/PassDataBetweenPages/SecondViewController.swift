//
//  SecondViewController.swift
//  PassDataBetweenPages
//
//  Created by ArronStudio on 2019-06-24.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit

protocol CanReceive {
    func dataReceived(data: String)
}

class SecondViewController: UIViewController {
    
    var data = ""
    var delegate : CanReceive?

    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label2.text = data

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toToFirstPage(_ sender: Any) {
        delegate?.dataReceived(data: text2.text!)
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
