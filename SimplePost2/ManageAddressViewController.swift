//
//  ManageAddressViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 25..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import Contacts
class ManageAddressViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    @IBOutlet weak var navBar: MainNavigationView!
    
    @IBOutlet weak var searchBarHeightLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var store = CNContactStore()
    var contacts = [CNContact]()
    var contactsVO = [ContactsVO]()
    var filteredVO = [ContactsVO]()
    var isSearching: Bool = false
    var shouldShowSearchResults: Bool = false
    func initNavigationView() {
        self.navBar.setTitle(title: "주소관리")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
        self.navBar.setBGColor(color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        // Do any additional setup after loading the view.
        self.navBar.initButtons()
        self.navBar.leftButton.setImage(UIImage(named: "back"), for: .normal)
        self.navBar.rightButton.setImage(UIImage(named: "search"), for: .normal)
        self.navBar.leftButton.isHidden = false
        self.navBar.rightButton.isHidden = false
        self.navBar.leftButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        self.navBar.rightButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        self.searchBarHeightLayoutConstraint.constant = 0
        
        self.searchBar.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        print(tableView.tag)
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return self.filteredVO.count
        }
        return self.contactsVO.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageAddress", for: indexPath)
        if(isSearching){
            let data = self.filteredVO[indexPath.row].getData()
            cell.textLabel?.text = data.name
            cell.detailTextLabel?.text = data.phone
        }else{
            if contactsVO.count > 0 {
                let data = self.contactsVO[indexPath.row].getData()
                cell.textLabel?.text = data.name
                cell.detailTextLabel?.text = data.phone
                
            }
        }
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        requestAccess()
    }
    @objc
    func handleBack(){
        print("hello")
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    func handleSearch(){
        if(self.searchBarHeightLayoutConstraint.constant == 0 ){
            self.searchBarHeightLayoutConstraint.constant = 56
        }else{
            self.searchBarHeightLayoutConstraint.constant = 0
            self.searchBar.text = ""
            self.searchBar.resignFirstResponder()
            isSearching = false
            shouldShowSearchResults = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @objc
    func keyboardWillShow(_ noti: Notification){
        print("keyboardShow")
        if let info = noti.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect{
            self.tableViewBottomConstraint.constant = info.height * -1
            self.view.layoutIfNeeded()
        }
    }
    @objc
    func keyboardWillHide(_ noti: Notification){
        print("keyboardHide")
        self.tableViewBottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        shouldShowSearchResults = true
        if(searchText.isEmpty){
            shouldShowSearchResults = false
            isSearching = false
        }else{
            isSearching = true
        }
        
        self.filteredVO = contactsVO.filter({ (a) -> Bool in
            (a.getData().name?.lowercased().contains(searchText.lowercased()))!
        })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}
extension ManageAddressViewController{
    func requestAccess() {
        
        store.requestAccess(for: .contacts) { (granted, error) in
            if granted {
                // 연락처 사용권한 획득 성공
                let containerId = self.store.defaultContainerIdentifier()
                let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
                if let contacts = try? self.store.unifiedContacts(matching: predicate,keysToFetch: [CNContactFamilyNameKey, CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactPostalAddressesKey] as [CNKeyDescriptor]){
                    self.contacts = contacts
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                        self.loadContactsToVO()
                    })
                }
            } else {
                // 연락처 사용권한 획득 실패
                let alertController = UIAlertController (title: "권한 요청", message: "설정에서 연락처 접근을 허용해주세요", preferredStyle: .alert)
                
                let settingsAction = UIAlertAction(title: "설정", style: .default) { (_) -> Void in
                    guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                print("Settings opened: \(success)") // Prints true
                            })
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
                alertController.addAction(cancelAction)
                alertController.addAction(settingsAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    func loadContactsToVO(){
        self.contactsVO.removeAll()
        self.filteredVO.removeAll()
        for contact in contacts{
            let contactsVO = ContactsVO()
            contactsVO.contact = contact
            self.contactsVO.append(contactsVO)
        }
        self.tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = self.tableView.indexPathForSelectedRow?.row
        if isSearching{
            let contact = self.filteredVO[row!].contact
            let vc = segue.destination as! EditContactViewController
            vc.contact = contact?.mutableCopy() as! CNMutableContact
            self.isSearching = false
            self.shouldShowSearchResults = false
            self.searchBar.text = ""
            self.tableView.reloadData()
        }else{
            let contact = self.contactsVO[row!].contact
            let vc = segue.destination as! EditContactViewController
            vc.contact = contact?.mutableCopy() as! CNMutableContact
        }
    }
}
