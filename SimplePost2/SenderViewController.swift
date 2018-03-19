//
//  SenderViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 25..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import CoreImage
class SenderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SPAddress {
    var postalField: String{
        get{
            return self.postalCodeField.text ?? ""
        }
        set{
            self.postalCodeField.text = newValue
        }
    }
    var addrField: String {
        get{
            return self.addressField.text ?? ""
        }
        set{
            self.addressField.text = newValue
        }
    }
    var alert : QRAlertView!
    let defaults = UserDefaults.standard
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var postalCodeField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var detailFfield: UITextField!
    var defaultsVO = Dictionary<String, Any>()
    @IBOutlet weak var navBar: MainNavigationView!
    var senderQRImageView : UIImageView!
    var qrcodeImage: CIImage!
    var selectedVO = [ContactsVO]()
    func initNavigationView() {
        self.navBar.setTitle(title: "발신자 정보")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
        self.navBar.setBGColor(color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        if let vo = defaults.value(forKey: "defaultsVO") as? [String:String]{
            self.defaultsVO = vo
        }
        self.navBar.leftButton.setImage(UIImage(named: "back"), for: .normal)
        self.navBar.leftButton.isHidden = false
        self.navBar.leftButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        self.navBar.rightButton.setImage(UIImage(named: "cm_pen_white"), for: .normal)
        self.navBar.rightButton.isHidden = false
        self.navBar.rightButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        
        prepareField()
        nameField.delegate = self
        phoneField.delegate = self
        mobileField.delegate = self
        postalCodeField.delegate = self
        addressField.delegate = self
        detailFfield.delegate = self
    }
    func prepareField(){
        nameField.text = defaultsVO["name"] as? String ?? ""
        phoneField.text = defaultsVO["phone"] as? String ?? ""
        mobileField.text = defaultsVO["mobile"] as? String ?? ""
        postalCodeField.text = defaultsVO["postalCode"] as? String ?? ""
        addressField.text = defaultsVO["address"] as? String ?? ""
        detailFfield.text = defaultsVO["detail"] as? String ?? ""
    }
    @objc func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handleReset(){
        let alert = UIAlertController(title: "경고", message: "새로 입력하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "네", style: .default) { (_) in
            self.nameField.text =  ""
            self.phoneField.text =  ""
            self.mobileField.text =  ""
            self.postalCodeField.text =  ""
            self.addressField.text =  ""
            self.detailFfield.text =  ""
        }
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedVO.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectedCell", for: indexPath)
        let data = self.selectedVO[indexPath.row].getData()
        cell.textLabel?.text = "\(data.name!)(\(data.phone!))"
        if (data.address?.isEmpty)!{
            cell.detailTextLabel?.text = "주소 정보가 없습니다."
        }else{
            cell.detailTextLabel?.text = data.address
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchAddressViewController{
            vc.ReturnController = self
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func QRSendAction(_ sender: Any) {
        let saveAlert = UIAlertController(title: "알림", message: "주소 정보를 새로 저장할까요?", preferredStyle: .alert)
        let saveOkAction = UIAlertAction(title: "네", style: .default) { (_) in
            self.defaultsVO["name"] = self.nameField.text ?? ""
            self.defaultsVO["phone"] = self.phoneField.text ?? ""
            self.defaultsVO["mobile"] = self.mobileField.text ?? ""
            self.defaultsVO["postalCode"] = self.postalCodeField.text ?? ""
            self.defaultsVO["address"] = self.addressField.text ?? ""
            self.defaultsVO["detail"] = self.detailFfield.text ?? ""
            
            self.defaults.setValue(self.defaultsVO, forKey: "defaultsVO")
            self.callQRAlert()
        }
        let saveNoAction = UIAlertAction(title: "아니오", style: .default){(_) in
            self.callQRAlert()
        }
        saveAlert.addAction(saveOkAction)
        saveAlert.addAction(saveNoAction)
        self.present(saveAlert, animated: true, completion: nil)
    }
    func callQRAlert(){
        let text = "\(nameField.text!);\(phoneField.text!);\(addressField.text!);"
        let data = text.data(using: String.Encoding.utf8, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter?.outputImage
        
        self.alert = QRAlertView()
        alert.QRImageView.image = UIImage(ciImage: qrcodeImage)
        alert.nameLabel.text = "이름 : \(nameField.text!)"
        alert.phoneLabel.text = "휴대폰번호 : \(phoneField.text!)"
        alert.addressLabel.text = "주소 : \(addressField.text!)"
        self.view.addSubview(alert)
        
        alert.top(self.view.topAnchor)
        alert.left(self.view.leftAnchor)
        alert.width(self.view.widthAnchor)
        alert.height(self.view.heightAnchor)
        alert.titleLabel.text = "보낸 사람"
        alert.nextButton.addTarget(self, action: #selector(callQRViewController), for: .touchUpInside)
        
    }
    @objc func callQRViewController(){
        let sb = UIStoryboard(name: "sender", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "qrVC") as! QRViewController
        vc.image = self.qrcodeImage
        vc.recieveVO = selectedVO
        self.alert.removeFromSuperview()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func handlePostAll(){
        let fileName = "export.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "주문자명,우편번호,주문자주소,주문자전화번호,수취인명,우편번호,수취인주소,수취인휴대폰,수취인전화번호,중량,부피,등기번호"
        for row in selectedVO{
            let data = row.getData()
            csvText = "\(csvText)\n\(nameField.text!),\(postalCodeField.text!),\(addressField.text!),\(mobileField.text!),\(data.name!),\(data.postalCode!),\(data.address!), 0\(data.phone!)"
        }
        do{
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            let vc = UIActivityViewController(activityItems: [path!], applicationActivities: [])
            vc.excludedActivityTypes = [
                .assignToContact,
                .saveToCameraRoll,
                .postToFlickr,
                .postToVimeo,
                .postToTencentWeibo,
                .postToTwitter,
                .postToFacebook,
                UIActivityType.openInIBooks
            ]
            self.present(vc, animated: true, completion: nil)
        }
        catch{
            
        }
    }
    @IBAction func handleAdd(_ sender: Any) {
        handleBack()
    }
}
