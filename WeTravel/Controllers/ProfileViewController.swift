//
//  ProfileViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//
import UIKit

class ProfileViewController: UIViewController {
    var profileSaveButtonClick:(()->Void)?
   
    @IBOutlet weak var cantainerView: UIView!
    @IBOutlet weak var btnSavr: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
          btnSavr.layer.cornerRadius = 33
        }
        self.cantainerView.isHidden = true
        self.btnSavr.isHidden = true
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
            self.cantainerView.isHidden = false
            self.btnSavr.isHidden = false
        }
        findButtonManage(isBlue: false)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "sidemenu", sender: self)

    }
    @IBAction func saveButtonClick(_ sender: Any) {
        if let comp = profileSaveButtonClick {
            comp()
        }
    }
    
    internal func findButtonManage(isBlue : Bool) {
        if isBlue {
            btnSavr.backgroundColor = UIColor.blueAppColor
            // imgRightArrow.image = #imageLiteral(resourceName: "RightArrow")
            btnSavr.setTitleColor(UIColor.white, for: .normal)
        } else {
            btnSavr.backgroundColor = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1)
            //  imgRightArrow.image = #imageLiteral(resourceName: "disableArrow")
            btnSavr.setTitleColor(UIColor.lightGray, for: .normal)
        }
        btnSavr.isEnabled = isBlue
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProfileTableViewController {
            vc.perentVC = self
        }
        if let vc = segue.destination as? SideMenuViewController {
            vc.navigationControllerIs = self.navigationController
        }

    }
    

}
