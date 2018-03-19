//
//  QRViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 31..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import CoreImage
class QRViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var recieveVO : [ContactsVO]?
    
    @IBOutlet weak var navBar: MainNavigationView!
    var recieveQRImage = [UIImage]()
    var image : CIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let queue = DispatchQueue.global()
        queue.sync {
            self.loadImage()
        }
    }
    func initNavigationView() {
        self.navBar.setTitle(title: "수신자 정보")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
        self.navBar.setBGColor(color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1))
        self.navBar.leftButton.setImage(UIImage(named: "back"), for: .normal)
        self.navBar.leftButton.isHidden = false
        self.navBar.leftButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    @objc
    func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    func loadImage(){
        for row in recieveVO!{
            let datas = row.getData()
            let text = "\(datas.name!);\(datas.phone!);\(datas.address!);"
            let data = text.data(using: String.Encoding.utf8, allowLossyConversion: false)
            var qrcodeImage = CIImage()
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            qrcodeImage = (filter?.outputImage)!
            self.recieveQRImage.append(UIImage(ciImage: qrcodeImage))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! QRDetailCell
        let data = recieveVO?[indexPath.row].getData()
        let name = data?.name
        let phone = data?.phone
        let addr = data?.address
        
        if self.recieveQRImage.count > 0{
            let image = recieveQRImage[indexPath.row]
            cell.qrImageView.image = image
        }
        
        
        cell.nameLabel.text = "이름: \(name!)"
        cell.phoneLabel.text = "번호: \(phone!)"
        if addr!.isEmpty {
            cell.addressLabel.text = "주소: 주소정보가 없습니다."
        }else{
            cell.addressLabel.text = "주소: \(addr!)"
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recieveVO!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
