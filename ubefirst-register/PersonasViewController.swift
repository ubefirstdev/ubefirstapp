//
//  PersonasViewController.swift
//  ubefirst-register
//
//  Created by Luis Oliva on 29/12/18.
//  Copyright © 2018 roman. All rights reserved.
//

import UIKit

class PersonasViewController: UIViewController {

    @IBOutlet weak var button_persona1: UIButton!
    
    @IBOutlet weak var button_persona2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button_persona1.setTitle(userData.hijos[0].alias, for: .normal)
        self.button_persona2.setTitle(userData.hijos[1].alias, for: .normal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
