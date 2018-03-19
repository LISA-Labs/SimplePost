//
//  GroupDetailViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 8. 1..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import Contacts
class GroupDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var navBar: MainNavigationView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    var group : CNMutableGroup!
    var contacts = [CNMutableContact]()
    let store = CNContactStore()
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Data"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initNavigationView()
        self.navBar.leftButton.setImage(UIImage(named: "back"), for: .normal)
        
        self.navBar.leftButton.isHidden = false
        self.navBar.leftButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        self.navBar.rightButton.setImage(UIImage(named: "add"), for: .normal)
        self.navBar.rightButton.isHidden = false
        self.navBar.rightButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
    }
    @objc func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    func fetch(keyword : String? = nil, completion : @escaping ([String])->()){
        completion(["String","String"])
    }
    func test(){
       
    }
    @objc func handleAdd(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "privatePost") as! PrivatePostViewController
        vc.returnViewController = self
        vc.group = self.group.mutableCopy() as! CNMutableGroup
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        refreshContacts()
    }
    func refreshContacts(){
        do{
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: group.identifier)
            let mutableContacts = try store.unifiedContacts(matching: predicate, keysToFetch: [CNContactFamilyNameKey, CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactPostalAddressesKey] as [CNKeyDescriptor])
            var newContacts = [CNMutableContact]()
            for row in mutableContacts{
                newContacts.append(row.mutableCopy() as! CNMutableContact)
            }
            self.contacts = newContacts
        }
        catch{
            
        }
        if self.contacts.count > 0{
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                for row in self.view.subviews{
                    if row == self.label{
                        self.label.removeFromSuperview()
                    }
                }
                
                self.navBar.setTitle(title: "\(self.group.name)(\(self.contacts.count))")
            }
        }else{
            self.tableView.isHidden = true
        }
        self.tableView.reloadData()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "groupDetailCell")
        let vo = ContactsVO()
        vo.contact = self.contacts[indexPath.row]
        
        cell?.textLabel?.text = vo.getData().name
        return cell!
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "삭제") { (action, indexPath) in
            let row = indexPath.row
            let contact = self.contacts[row]
            let request = CNSaveRequest()
            do{
                request.removeMember(contact, from: self.group)
                self.refreshContacts()
                if self.contacts.count == 0{
                    self.tableView.reloadData()
                    self.tableView.isHidden = true
                    self.prepareNoDataLabel()
                }
            }
            catch{
                
            }
            try! self.store.execute(request)
            self.refreshContacts()
        }
        return [deleteAction]
    }
    func initNavigationView(){
        do{
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: group.identifier)
            let mutableContacts = try store.unifiedContacts(matching: predicate, keysToFetch: [CNContactFamilyNameKey, CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactPostalAddressesKey] as [CNKeyDescriptor])
            for row in mutableContacts{
                self.contacts.append(row.mutableCopy() as! CNMutableContact)
            }
        }
        catch{
            
        }
        self.navBar.setTitle(title: "\(group.name)(\(contacts.count))")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
        self.navBar.setBGColor(color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1))
        navBar.rightButton.isHidden = false
        if self.contacts.count == 0{
            self.tableView.isHidden = true
            prepareNoDataLabel()
        }
        else{
        }
    }
    
    func prepareNoDataLabel(){
        self.view.addSubview(label)
        label.centerX(self.view)
        label.centerY(self.view)
        label.width(width: 100).isActive = true
        label.height(height: 100).isActive = true
    }
}
