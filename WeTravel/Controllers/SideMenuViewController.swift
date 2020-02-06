//
//  SideMenuViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import UIKit

var selectedTab = 0

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewLeadingContraint: NSLayoutConstraint!
    @IBOutlet weak var viewBackground: UIView!
    
    var navigationControllerIs: UINavigationController?
    var sideMenuItems = ["Book Tickets", "My Tickets", "My Profile", "Settings"]
    var icons = ["nav_home_unselected", "nav_my_ticket_unselected","nav_my_profile_unselected" , "Setting Icon"]
    var selectedicons = ["nav_home_selected", "nav_my_ticket_selected", "nav_my_profile_selected" , "Setting Icon Blue"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewLeadingContraint.constant = -255
        viewBackground.isHidden = true
        tableView.tableFooterView = UIView.init()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.sideMenuButtonClick("")
        }
    }
    
    func sideMenuButtonClick(_ sender: Any) {
        self.tableViewLeadingContraint.constant = 0
        viewBackground.isHidden = false
        viewBackground.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.viewBackground.alpha = 1
        }) { (_) in
            
        }
    }
    
    @IBAction func tabgestureClick(_ sender: UITapGestureRecognizer) {
        self.tableViewLeadingContraint.constant = -255
        viewBackground.isHidden = false
        viewBackground.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.viewBackground.alpha = 0
        }) { (_) in
            self.viewBackground.isHidden = true
            self.dismiss(animated: false, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let viewSide = cell.viewWithTag(10)
        let imgIcon = cell.viewWithTag(20) as? UIImageView
        let lblTitle = cell.viewWithTag(30) as? UILabel
        lblTitle?.text = sideMenuItems[indexPath.row]
        if selectedTab == indexPath.row {
            viewSide?.isHidden = false
            imgIcon?.image = UIImage.init(named: selectedicons[indexPath.row])
        } else {
            viewSide?.isHidden = true
            imgIcon?.image = UIImage.init(named: icons[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header")
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabgestureClick(UITapGestureRecognizer())
        if selectedTab == indexPath.row { return }
        selectedTab = indexPath.row
        tableView.reloadData()
        
        if selectedTab == 0 {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindBusViewControllers")
            self.navigationControllerIs?.setViewControllers([vc], animated: true)
        }
        if selectedTab == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTicketsViewController")
            //self.navigationController?.pushViewController(vc, animated: true)
            self.navigationControllerIs?.setViewControllers([vc], animated: true)
        }
        if selectedTab == 2 {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
            self.navigationControllerIs?.setViewControllers([vc], animated: true)
        }
        if selectedTab == 3 {
            //SettingsViewController
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController")
            self.navigationControllerIs?.setViewControllers([vc], animated: true)
        }
//        if let comp = gottoAnotherScreenBySideMenu {
//            comp(indexPath.row)
//        }
    }
}
