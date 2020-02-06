//
//  FindBusViewControllers.swift
//  WeTravel
//
//  Created by Mayank Sharma on 16/09/19.
//  Copyright © 2019 Mayank Sharma. All rights reserved.
//

import UIKit

class FindBusViewControllers: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var imgFullScreenImage: UIImageView!
    @IBOutlet weak var perentViewOfFromAndTo: UIView!
    @IBOutlet weak var collectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet var viewFullImage: UIView!
    @IBOutlet weak var lblDateAlert: UILabel!
    @IBOutlet weak var dateAlertView: UIView!
    @IBOutlet weak var lblToAlertText: UILabel!
    @IBOutlet weak var lblAlertText: UILabel!
    @IBOutlet weak var btnFindBus: UIButton!
    @IBOutlet weak var toAlertView: UIView!
    @IBOutlet weak var fromAlertView: UIView!
    @IBOutlet weak var txtFromWhere: UITextField!
    @IBOutlet weak var txtToWhere: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var parentViewFirstViewOfScroll: UIView!
    
    var fromCity : Cities?
    var toCity : Cities?
    let datePicker = UIDatePicker()
    var dropDown = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustumDropDownViewController") as? CustumDropDownViewController
    var destinationAndDepartur : DestinationAndDeparture?
    var offerres : OffersResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                self.offerres = try jsonDecoder.decode(OffersResponse.self, from: data)
            } catch {
                // handle error
            }
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        txtDate.text = formatter.string(from: Date())
        fromAlertView.isHidden = true
        toAlertView.isHidden = true
        dateAlertView.isHidden = true
        self.findButtonManage(isBlue: true)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            btnFindBus.layer.cornerRadius = 33
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showDatePicker()
        self.collectionViewHeightContraint.constant =  55 / 100 * ((view.frame.width - 20) < 400 ? (view.frame.width - 20) : 400) + 50
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.collectionViewHeightContraint.constant =  55 / 100 * ((view.frame.width - 20) < 400 ? (view.frame.width - 20) : 400) + 90
        }
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    private func findButtonManage(isBlue : Bool) {
        if isBlue {
            btnFindBus.backgroundColor = UIColor.blueAppColor
            // imgArrowOfButton.image = #imageLiteral(resourceName: "RightArrow")
            btnFindBus.setTitleColor(UIColor.white, for: .normal)
        } else {
            btnFindBus.backgroundColor = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1)
            //   imgArrowOfButton.image = #imageLiteral(resourceName: "disableArrow")
            btnFindBus.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }
    
    @IBAction func findButtonClick(_ sender: Any) {
        
        if txtFromWhere.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            lblAlertText.text = "No result for this departure"
            fromAlertView.isHidden = false
            findButtonManage(isBlue: false)
        } else if txtToWhere.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            lblAlertText.text = "No result for this destination"
            toAlertView.isHidden = false
            findButtonManage(isBlue: false)
        } else if txtDate.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            lblDateAlert.text = "Please select date"
            dateAlertView.isHidden = false
            findButtonManage(isBlue: false)
        } else {
            toAlertView.isHidden = true
            fromAlertView.isHidden = true
            dateAlertView.isHidden = true
            appDelegateObject().startIndicator()
            DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
                appDelegateObject().stopIndicator()
                self.gotoNextScreen()
            }
            
            
        }
    }
    
    func gotoNextScreen()  {
        if let path = Bundle.main.path(forResource: "search_success", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                var searchRes = try jsonDecoder.decode(SearchResponse.self, from: data)
                
                let newres = searchRes.travelDetails?.filter({ (travel) -> Bool in
                    return travel.departure == self.txtFromWhere.text && travel.destination == self.txtToWhere.text && travel.travelWeekDay?.contains("\(self.getDayOfWeek(txtDate.text ?? "") ?? 0)") ?? false
                })
                if newres?.count == 0 {
                    self.findButtonManage(isBlue: false)
                    self.toAlertView.isHidden = false
                    self.lblToAlertText.text = "No result for this destination"
                } else {
                    self.findButtonManage(isBlue: true)
                    let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController
                    searchRes.travelDetails = newres
                    controller?.searchRes = searchRes
                    controller?.fromCity = self.fromCity
                    controller?.toCity = self.toCity
                    controller?.strDate = self.txtDate.text
                    self.navigationController?.show(controller ?? UIViewController(), sender: self)
                    
                }
                print(newres ?? "")
            } catch {
                // handle error
            }
        }
    }
    
    @IBAction func closeFullImage(_ sender: Any) {
        viewFullImage.removeFromSuperview()
    }
    @IBAction func seeoreButtonClick(_ sender: Any) {
        viewFullImage.frame = appDelegate.window?.frame ?? CGRect.zero
        appDelegate.window?.addSubview(viewFullImage)
    }
    @IBAction func sideMenuButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "sidemenu", sender: self)
    }
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let path = Bundle.main.path(forResource: "departure", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                self.destinationAndDepartur = try jsonDecoder.decode(DestinationAndDeparture.self, from: data)
                self.dropdownShow(textField: textField)
            } catch {
                // handle error
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dropDown?.view.removeFromSuperview()
        textField.resignFirstResponder()
        return true
    }
    
    private func dropdownShow(textField : UITextField) {
        self.dropDown?.view.removeFromSuperview()
        dropDown? = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustumDropDownViewController") as! CustumDropDownViewController
        dropDown?.arrDropDownData = destinationAndDepartur?.cities
        dropDown?.view.frame = CGRect.init(x: textField.frame.origin.x, y: textField.frame.maxY + perentViewOfFromAndTo.frame.origin.y, width: textField.frame.width - 50, height: textField.frame.width - 50)
        dropDown?.tableView.layer.borderColor = UIColor.lightGray.cgColor
        dropDown?.didSelect = { (str, index) in
            if self.txtFromWhere == textField {
                if self.toCity?.id == str?.id {
                    self.fromAlertView.isHidden = false
                    self.lblAlertText.text = "From and to cannot be same"
                    return
                } else {
                    self.fromAlertView.isHidden = true
                }
                self.fromCity = str
            } else {
                if self.fromCity?.id == str?.id {
                    self.toAlertView.isHidden = false
                    self.lblToAlertText.text = "From and to cannot be same"
                    return
                } else {
                    self.toAlertView.isHidden = true
                }
                self.toCity = str
            }
            textField.text = str?.city_name
            self.findButtonManage(isBlue: true)
            self.dropDown?.view.removeFromSuperview()
            textField.resignFirstResponder()
        }
        dropDown?.textField = textField
        self.parentViewFirstViewOfScroll.addSubview(dropDown?.view ?? UIView())
        self.addChild(dropDown ?? UIViewController())
        //   self.tableView.isScrollEnabled = false
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dropDown?.view.removeFromSuperview()
        self.view.endEditing(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dropDown?.view.removeFromSuperview()
    }

}

// MARK: - Date picker
extension FindBusViewControllers {
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.backgroundColor = UIColor.white
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.barTintColor = UIColor.white
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        doneButton.tintColor = UIColor.black
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        cancelButton.tintColor = UIColor.black
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        if txtDate.text != formatter.string(from: datePicker.date) {
            self.findButtonManage(isBlue: true)
        }
        txtDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SideMenuViewController {
            vc.navigationControllerIs = self.navigationController
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension FindBusViewControllers : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerres?.offers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCollectionViewCell
        let data = offerres?.offers?[indexPath.row]
        cell.imgBanner.image = UIImage.init(named: data?.offerBanner ?? "")
        cell.lblToFromDestination.text = data?.offerDesc
        if let txt = data?.offerPrice, txt != "" {
            cell.lblPrice.text = "only at \(currencySign)\(txt)"
        } else {
            cell.lblPrice.text = ""
        }
        if let code = data?.offerCode, code != "" {
            cell.lblCouper.text = code
            cell.lblCouper.backgroundColor = UIColor.white
        } else {
            cell.lblCouper.text = ""
            cell.lblCouper.backgroundColor = UIColor.clear
        }
        cell.btnSeeMore.isHidden = indexPath.row == 1 ? true : false
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            cell.topConstraint.constant = 5
        case 1136:
            cell.topConstraint.constant = 10
        case 1334:
            cell.topConstraint.constant = 20
        case 1792:
            cell.topConstraint.constant = 20
        case 1920, 2208:
            cell.topConstraint.constant = 30
        case 2436:
            cell.topConstraint.constant = 26
        case 2688:
            cell.topConstraint.constant = 36
        default:
            cell.topConstraint.constant = 36
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    // SIZE FOR COLLECTION VIEW CELL
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: ((view.frame.width - 25) < 400 ? (view.frame.width - 25) : 400) , height: 55 / 100 * ((view.frame.width - 20) < 400 ? (view.frame.width - 20) : 400))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewFullImage.frame = appDelegate.window?.frame ?? CGRect.zero
        let data = offerres?.offers?[indexPath.row]
        imgFullScreenImage.image = UIImage.init(named: data?.actionBanner ?? "")
        appDelegate.window?.addSubview(viewFullImage)
    }
    
}
// MARK: - Collectiion view custem cell
class OffersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var lblCouper: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblToFromDestination: UILabel!
    override func awakeFromNib() {
    }
}
