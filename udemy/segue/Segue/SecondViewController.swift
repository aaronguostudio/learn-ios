//
//  SecondViewController.swift
//  Segue
//
//  Created by ArronStudio on 2019-06-23.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var passText : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = passText
        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToFirstPage", sender: self)
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
