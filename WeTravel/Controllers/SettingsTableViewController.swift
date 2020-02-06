//
//  SettingsTableViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var txtLaunchId: UITextField!
    @IBOutlet weak var txtHomeOfficeFilter: UITextField!
    @IBOutlet weak var txtSearchOfficeFilter: UITextField!
    @IBOutlet weak var txtSettingDeal: UITextField!
    @IBOutlet weak var txtPaymentDeals: UITextField!
    
    var perentVC = SettingsViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        txtLaunchId.leftPeddingPoint = 10
        txtHomeOfficeFilter.leftPeddingPoint = 10
        txtSearchOfficeFilter.leftPeddingPoint = 10
        txtSettingDeal.leftPeddingPoint = 10
        txtPaymentDeals.leftPeddingPoint = 10
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        selectedTab = 3
        let settingDails = UserDefaults.getSettingsDetails()
        if let launchid = settingDails.0 {
            txtLaunchId.text = launchid
        }
        if let homeOffer = settingDails.1 {
            txtHomeOfficeFilter.text = homeOffer
        }
        if let searchOffer = settingDails.2 {
            txtSearchOfficeFilter.text = searchOffer
        }
        if let settingDeaal = settingDails.3 {
            txtSettingDeal.text = settingDeaal
        }
        if let payment = settingDails.4 {
            txtPaymentDeals.text = payment
        }
        
        perentVC.settingSaveButtonComp = {
            appDelegateObject().startIndicator()
            DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
                appDelegateObject().stopIndicator()
                UserDefaults.saveSettingsInfo(launchID: self.txtLaunchId.text, homeOfferRecommendation: self.txtHomeOfficeFilter.text, searchOfferFilter: self.txtSearchOfficeFilter.text, seatingDeals: self.txtSettingDeal.text, payments_Offers: self.txtPaymentDeals.text)
                self.perentVC.showToast(message: "Serttings saved succesfully")
                self.perentVC.findButtonManage(isBlue: false)
            }
        }
        
        txtLaunchId?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtHomeOfficeFilter?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtSearchOfficeFilter?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtSettingDeal?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtPaymentDeals?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if txtLaunchId.text?.isBlank ?? false {
            perentVC.findButtonManage(isBlue: false)
        } else if txtHomeOfficeFilter.text?.isBlank ?? false {
            perentVC.findButtonManage(isBlue: false)
        } else if txtSearchOfficeFilter.text?.isBlank ?? false {
            perentVC.findButtonManage(isBlue: false)
        } else if txtSettingDeal.text?.isBlank ?? false {
            perentVC.findButtonManage(isBlue: false)
        }  else if txtPaymentDeals.text?.isBlank ?? false {
            perentVC.findButtonManage(isBlue: false)
        }  else {
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
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
