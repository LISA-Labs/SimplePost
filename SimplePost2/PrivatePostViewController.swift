//
//  PrivatePostViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 25..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import Contacts
class PrivatePostViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    // MARK: Vars
    var returnViewController : GroupDetailViewController?
    var group : CNGroup!
    @IBOutlet weak var setButtonBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBar: MainNavigationView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var store = CNContactStore()
    var contacts = [CNContact]()
    var contactsVO = [ContactsVO]()
    var filteredVO = [ContactsVO]()
    var isSearching: Bool = false
    var shouldShowSearchResults: Bool = false
    func initNavigationView() {
        if let returnVC = self.returnViewController{
            self.navBar.setTitle(title: "연락처 선택")
        }else{
            self.navBar.setTitle(title: "개인발송")
        }
        
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
        self.requestAccess()
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "privatePostCell", for: indexPath) as! PrivatePostTableViewCell
        if(isSearching){
            if self.filteredVO[indexPath.row].isSelected{
                cell.checkImageView.isHighlighted = true
            }else{
                cell.checkImageView.isHighlighted = false
            }
            let data = self.filteredVO[indexPath.row].getData()
            cell.nameLabel.text = data.name
            cell.phoneLabel.text = data.phone
        }else{
            if(self.contactsVO.count > 0){
                if self.contactsVO[indexPath.row].isSelected{
                    cell.checkImageView.isHighlighted = true
                }else{
                    cell.checkImageView.isHighlighted = false
                }
                let data = self.contactsVO[indexPath.row].getData()
                cell.nameLabel.text = data.name
                cell.phoneLabel.text = data.phone
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            if filteredVO.count > 0{
                if self.filteredVO[indexPath.row].isSelected{
                    self.filteredVO[indexPath.row].isSelected = false
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }else{
                    self.filteredVO[indexPath.row].isSelected = true
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }else{
            if self.contactsVO[indexPath.row].isSelected{
                
                
                DispatchQueue.main.async {
                    self.contactsVO[indexPath.row].isSelected = false
                    self.tableView.reloadData()
                }
            }else{
                
                self.contactsVO[indexPath.row].isSelected = true
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
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
            self.searchBar.becomeFirstResponder()
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
            DispatchQueue.main.async {
                self.setButtonBottomLayoutConstraint.constant = info.height
                self.view.layoutIfNeeded()
            }
            
        }
    }
    @objc
    func keyboardWillHide(_ noti: Notification){
        print("keyboardHide")
        self.setButtonBottomLayoutConstraint.constant = 0
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
        DispatchQueue.main.async {
        self.filteredVO = self.contactsVO.filter({ (a) -> Bool in
            (a.getData().name?.lowercased().contains(searchText.lowercased()))!
        })
        
            self.tableView.reloadData()
        }
        
    }
    
}
extension PrivatePostViewController{
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
    
    @IBAction func handleButton(){
        if let retrunVC = self.returnViewController{
            handleAdd()
        }else{
            handleSelect()
        }
    }
    func handleAdd(){
        let modifyRequest = CNSaveRequest()
        for row in self.contactsVO{
            if row.isSelected {
                modifyRequest.addMember(row.contact, to: group)
            }
        }
        try! self.store.execute(modifyRequest)
        self.navigationController?.popViewController(animated: true)
    }
    func handleSelect(){
        var selectedVO = [ContactsVO]()
        for row in self.contactsVO{
            if row.isSelected {
                selectedVO.append(row)
            }
        }
        let sb = UIStoryboard(name: "sender", bundle: nil)
        
        let vc = sb.instantiateInitialViewController() as! SenderViewController
        vc.selectedVO = selectedVO
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
