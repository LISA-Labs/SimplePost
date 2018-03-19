//
//  GroupPostViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 25..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import Contacts
class GroupPostViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var navBar: MainNavigationView!
    let store = CNContactStore()
    var groups = [CNGroup]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func initNavigationView() {
        self.navBar.setTitle(title: "그룹발송")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        self.navBar.leftButton.setImage(UIImage(named: "back"), for: .normal)
        self.navBar.leftButton.isHidden = false
        self.navBar.leftButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        groups = try! store.groups(matching: nil)
        
    }
    @objc func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupPostCell", for: indexPath) as! GroupPostTableViewCell
        let data = self.groups[indexPath.row]
        cell.textLabel?.text = data.name
            do{
                
                let predicate = CNContact.predicateForContactsInGroup(withIdentifier: data.identifier)
                let keysToFetch = [CNContactGivenNameKey]
                let contacts = try self.store.unifiedContacts(matching: predicate, keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor])
                let count = contacts.count
                DispatchQueue.main.async {
                    cell.countLabel.text = String(count)
                   
                }
            }
            catch{
                
            }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = tableView.indexPathForSelectedRow?.row
        
        var selectedVO = [ContactsVO]()
        let predicate = CNContact.predicateForContactsInGroup(withIdentifier: self.groups[row!].identifier)
        do{
            let mutableContacts = try store.unifiedContacts(matching: predicate, keysToFetch: [CNContactFamilyNameKey, CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactPostalAddressesKey] as [CNKeyDescriptor])
            for row in mutableContacts{
                let vo = ContactsVO()
                vo.contact = row
                vo.isSelected = true
                selectedVO.append(vo)
            }
        }
        catch{
            
        }
        
        let vc = segue.destination as! SenderViewController
        vc.selectedVO = selectedVO
    }
}
