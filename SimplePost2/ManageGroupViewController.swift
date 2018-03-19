//
//  ManageGroupViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 25..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import Contacts
class ManageGroupViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var navBar: MainNavigationView!
    let store = CNContactStore()
    var groups = [CNGroup]()
    
    @IBOutlet weak var tableView: UITableView!
    func initNavigationView() {
        self.navBar.setTitle(title: "그룹관리")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
        self.navBar.setBGColor(color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
        self.navBar.leftButton.setImage(UIImage(named: "back"), for: .normal)
        self.navBar.leftButton.isHidden = false
        self.navBar.leftButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        self.navBar.rightButton.setImage(UIImage(named: "cm_add_white"), for: .normal)
        self.navBar.rightButton.isHidden = false
        self.navBar.rightButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        groups = try! store.groups(matching: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        groups = try! store.groups(matching: nil)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @objc func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleAddButton(){
        let alert = UIAlertController(title: "그룹 추가", message: "그룹 이름을 입력하세요", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "이름을 입력하세요"
        }
        let okAction = UIAlertAction(title: "추가", style: .default) { (action) in
            if let resultText = alert.textFields?.first?.text{
                let group = CNMutableGroup()
                group.name = resultText
                let request = CNSaveRequest()
                request.add(group, toContainerWithIdentifier: nil)
                try! self.store.execute(request)
                DispatchQueue.main.async {
                    self.groups = try! self.store.groups(matching: nil)
                    self.tableView.reloadData()
                }
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    let sb = UIStoryboard(name: "manageGroup", bundle: nil)
                    let newVC = sb.instantiateViewController(withIdentifier: "groupDetail") as! GroupDetailViewController
                    newVC.group = group.mutableCopy() as! CNMutableGroup
                    self.navigationController?.pushViewController(newVC, animated: true)
                })
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageGroupCell", for: indexPath) as! ManageGroupTableViewCell
        
        cell.textLabel?.text = self.groups[indexPath.row].name
        do{
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: self.groups[indexPath.row].identifier)
            let keysToFetch = [CNContactGivenNameKey]
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor])
            cell.countLabel.text = "\(contacts.count)"
        }
        catch{
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "삭제") { (action, indexPath) in
            let mutableGroup = self.groups[indexPath.row].mutableCopy() as! CNMutableGroup
            let request = CNSaveRequest()
            request.delete(mutableGroup)
            try! self.store.execute(request)
            DispatchQueue.main.async {
                self.groups = try! self.store.groups(matching: nil)
                self.tableView.reloadData()
            }
        }
        return [deleteAction]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = self.tableView.indexPathForSelectedRow?.row
        let rows = self.groups[row!]
        let vc = segue.destination as! GroupDetailViewController
        vc.group = rows.mutableCopy() as! CNMutableGroup
        
    }
    
}
