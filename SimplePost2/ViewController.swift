//
//  ViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 25..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import Contacts
class ViewController: UIViewController {
    // MARK: Vars
    @IBOutlet weak var navBar: MainNavigationView!
    @IBOutlet weak var privatePostButton: UIButton!
    @IBOutlet weak var groupPostButton: UIButton!
    @IBOutlet weak var manageAddressButton: UIButton!
    @IBOutlet weak var manageGroupButton: UIButton!
    var store = CNContactStore()
    
    func initNavigationView() {
        self.navBar.setTitle(title: "간편발송")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
        self.navBar.setBGColor(color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1))
    }
    func initBackgroundView() {
        self.view.backgroundColor = kWhiteHighlightColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initNavigationView()
        self.initBackgroundView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.privatePostButton.layer.cornerRadius = 5.0
        self.privatePostButton.layer.masksToBounds = true
        
        self.groupPostButton.layer.cornerRadius = 5.0
        self.groupPostButton.layer.masksToBounds = true
        
        self.manageAddressButton.layer.cornerRadius = 3.0
        self.manageAddressButton.layer.masksToBounds = true
        
        self.manageGroupButton.layer.cornerRadius = 3.0
        self.manageGroupButton.layer.masksToBounds = true
        
    }
    
    
}
