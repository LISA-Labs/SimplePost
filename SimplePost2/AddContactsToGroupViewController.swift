//
//  AddContactsToGroupViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 8. 1..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import Contacts
class AddContactsToGroupViewController: UIViewController {
    
    @IBOutlet weak var navBar: MainNavigationView!
    @IBOutlet weak var searchBar: UISearchBar!
    var group : CNGroup!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
