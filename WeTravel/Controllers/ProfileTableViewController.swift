//
//  ProfileTableViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import UIKit

class ProfileTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtLoyality: UITextField!
    var perentVC = ProfileViewController()
    var dropDown = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustumDropDownViewController") as? CustumDropDownViewController
    var loayalityArr: LoyalityResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        if let path = Bundle.main.path(forResource: "loyalty", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                self.loayalityArr = try jsonDecoder.decode(LoyalityResponse.self, from: data)
            } catch {
                // handle error
            }
        }
        
        txtAge.leftPeddingPoint = 10
        txtName.leftPeddingPoint = 10
        txtLoyality.leftPeddingPoint = 10
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        selectedTab = 2
        if let name = UserDefaults.getProfileDetails().0 {
          txtName.text = name
        }
        if let age = UserDefaults.getProfileDetails().1 {
            txtAge.text = age
        }
        if let loyality = UserDefaults.getProfileDetails().2 {
           txtLoyality.text = loyality
        }
        perentVC.profileSaveButtonClick = {
            appDelegateObject().startIndicator()
            DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
                appDelegateObject().stopIndicator()
                UserDefaults.saveProfileInfo(name: self.txtName.text, age: self.txtAge.text, loyality: self.txtLoyality.text)
                self.perentVC.showToast(message: "Profile saved succesfully")
                self.perentVC.findButtonManage(isBlue: false)
            }
        }
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        txtName?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtAge?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtLoyality?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if txtName.text?.isBlank ?? false {
           perentVC.findButtonManage(isBlue: false)
        } else if txtAge.text?.isBlank ?? false {
            perentVC.findButtonManage(isBlue: false)
        } else if txtLoyality.text?.isBlank ?? false {
            perentVC.findButtonManage(isBlue: false)
        } else {
            perentVC.findButtonManage(isBlue: true)
        }
    
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtLoyality {
            self.dropdownShow(textField: textField)
            return false
        }
        return true
    }
    
    private func dropdownShow(textField : UITextField) {
        self.dropDown?.view.removeFromSuperview()
        dropDown? = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustumDropDownViewController") as! CustumDropDownViewController
        var arrCity = [Cities]()
        for item in loayalityArr?.loyalties ?? [] {
            arrCity.append(Cities.init(id: item.id ?? "", city_code: "", city_name: item.name ?? ""))
        }
        dropDown?.arrDropDownData = arrCity
        dropDown?.view.frame = CGRect.init(x: textField.frame.origin.x, y: cell3.frame.maxY, width: textField.frame.width - 50, height: textField.frame.width - 50)
        dropDown?.tableView.layer.borderColor = UIColor.lightGray.cgColor
        dropDown?.didSelect = { (str, index) in
           textField.text = str?.city_name
            self.dropDown?.view.removeFromSuperview()
            textField.resignFirstResponder()
            self.textFieldDidChange(textField)
        }
        dropDown?.textFeldDidChangeStart = false
        dropDown?.textField = textField
        self.tableView.addSubview(dropDown?.view ?? UIView())
        self.addChild(dropDown ?? UIViewController())
        //   self.tableView.isScrollEnabled = false
    }

}
extension String {
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
}
