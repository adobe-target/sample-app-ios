//
//  SearchResultViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit

class SearchResultViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var sortByView: UIView!
    @IBOutlet weak var lblDate: UIButton!
    @IBOutlet weak var lblFromTo: UILabel!
    @IBOutlet weak var btnSortBy: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var btnRecommended: UIButton!
    @IBOutlet weak var recomdedCheck: UIButton!
    @IBOutlet weak var ratingCheck: UIButton!
    @IBOutlet weak var btnRating: UIButton!
    @IBOutlet weak var departureCheck: UIButton!
    @IBOutlet weak var btnDeparture: UIButton!
    @IBOutlet weak var journeyCheck: UIButton!
    @IBOutlet weak var btnJourney: UIButton!
    @IBOutlet weak var fareChecck: UIButton!
    @IBOutlet weak var btnFare: UIButton!
    
    @IBOutlet weak var lblDealText: UILabel!
    @IBOutlet weak var collectionViewExpendView: UIView!
    @IBOutlet weak var lblOffText: UILabel!
    @IBOutlet weak var imgRightArrow: UIImageView!
    
    var searchRes : SearchResponse?
    var toCity : Cities?
    var fromCity : Cities?
    var strDate : String?
    var selectedItemId : TravelDetails?
    var holdSearchRes : SearchResponse?

    
    @IBOutlet weak var lblTotalBusFound: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        holdSearchRes = searchRes
        self.lblTotalBusFound.text = "\(self.searchRes?.travelDetails?.count ?? 0) Buses found"
        lblDate.setTitle(strDate, for: .normal)
        lblFromTo.text = (fromCity?.city_code ?? "") + " to " + (toCity?.city_code ?? "")
        collectionViewExpendView.isHidden = true
        if UIDevice.current.userInterfaceIdiom == .pad {
            btnSearch.layer.cornerRadius = 33
        }
    }
    
    // MARK: - IBActions
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sorbyButtonClick(_ sender: Any) {
       // collectionViewExpendView.isHidden = true
        sortByView.frame = self.view.frame
        self.view.addSubview(sortByView)
    }
    
    @IBAction func recommendedButtonClick(_ sender: UIButton) {
        sortByView.removeFromSuperview()
        unSelectedAllSortByButtons()
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
        sender.isSelected = !sender.isSelected
            self.recomdedCheck.isSelected = sender.isSelected
            self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
            return (td1.recommended ?? "") > (td2.recommended ?? "")
        })
        self.tableView.reloadData()
        self.lblTotalBusFound.text = "\(self.searchRes?.travelDetails?.count ?? 0) Buses found"
            self.btnSortBy.setTitle("Recommended", for: .normal)
        }
    }
    
    @IBAction func fareButtonClick(_ sender: UIButton) {
        sortByView.removeFromSuperview()
        unSelectedAllSortByButtons()
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
        sender.isSelected = !sender.isSelected
            self.fareChecck.isSelected = sender.isSelected
            self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
            return (td1.travelPrice ?? "") < (td2.travelPrice ?? "")
        })
        self.tableView.reloadData()
        self.lblTotalBusFound.text = "\(self.searchRes?.travelDetails?.count ?? 0) Buses found"
            self.btnSortBy.setTitle("Fare", for: .normal)
        }
    }
    
    @IBAction func journeyButtonClick(_ sender: UIButton) {
        sortByView.removeFromSuperview()
        unSelectedAllSortByButtons()
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
        sender.isSelected = !sender.isSelected
            self.journeyCheck.isSelected = sender.isSelected
            self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
            return (td1.journeyTime ?? "") < (td2.journeyTime ?? "")
        })
        self.tableView.reloadData()
        self.lblTotalBusFound.text = "\(self.searchRes?.travelDetails?.count ?? 0) Buses found"
            self.btnSortBy.setTitle("Journey Time", for: .normal)
        }
    }
    
    @IBAction func departureButtonClick(_ sender: UIButton) {
        sortByView.removeFromSuperview()
        unSelectedAllSortByButtons()
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
        sender.isSelected = !sender.isSelected
            self.departureCheck.isSelected = sender.isSelected
            self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
            return (td1.departureTime ?? "") > (td2.departureTime ?? "")
        })
        self.tableView.reloadData()
        self.lblTotalBusFound.text = "\(self.searchRes?.travelDetails?.count ?? 0) Buses found"
            self.btnSortBy.setTitle("Departure Time", for: .normal)
        }
    }
    
    @IBAction func ratingButtonClick(_ sender: UIButton) {
        unSelectedAllSortByButtons()
        sortByView.removeFromSuperview()
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
            sender.isSelected = !sender.isSelected
            self.ratingCheck.isSelected = sender.isSelected
            self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
                return (td1.averageRating ?? "") > (td2.averageRating ?? "")
            })
            self.tableView.reloadData()
            self.lblTotalBusFound.text = "\(self.searchRes?.travelDetails?.count ?? 0) Buses found"
            self.btnSortBy.setTitle("Rating", for: .normal)
        }
    }
    
    @IBAction func tapOfSortView(_ sender: UITapGestureRecognizer) {
        if sender.view == sortByView {
            sortByView.removeFromSuperview()
        }
//        let indexPath = IndexPath(row: 0, section: 0)
//        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    @IBAction func closeTopExpendCellView(_ sender: Any) {
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
            self.unSelectedAllSortByButtons()
            self.collectionViewExpendView.isHidden = true
            self.searchRes = self.holdSearchRes
            self.tableView.reloadData()
            self.lblTotalBusFound.text = "\(self.searchRes?.travelDetails?.count ?? 0) Buses found"
        }
    }
    @IBAction func bookButtonClick(_ sender: Any) {
        guard (selectedItemId != nil) else {
            self.showToast(message: "Please Select one travels on list.")
            return
        }
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
            if UIDevice.current.userInterfaceIdiom == .phone {
                let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeatSelectionViewController") as? SeatSelectionViewController
                controller?.selectedTravelDetail = self.selectedItemId
                controller?.travelDate = self.lblDate.titleLabel?.text
                self.navigationController?.show(controller ?? UIViewController(), sender: self)
            } else {
                let controller = UIStoryboard.init(name: "SeatSelectionIpad", bundle: nil).instantiateViewController(withIdentifier: "SeatSelectionViewController") as? SeatSelectionViewController
                controller?.selectedTravelDetail = self.selectedItemId
                controller?.travelDate = self.lblDate.titleLabel?.text
                self.navigationController?.show(controller ?? UIViewController(), sender: self)
            }
        }
    }
    
    // MARK: - Other Mathods
    func unSelectedAllSortByButtons()  {
     
        btnSortBy.setTitle("", for: .normal)
        btnRecommended.isSelected = false
        btnFare.isSelected = false
        btnRating.isSelected = false
        btnJourney.isSelected = false
        btnDeparture.isSelected = false
        recomdedCheck.isSelected = false
        fareChecck.isSelected = false
        departureCheck.isSelected = false
        journeyCheck.isSelected = false
        ratingCheck.isSelected = false
        
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    func star(withRating rating: CGFloat, outOfTotal totalNumberOfStars: Int, withFontSize fontSize: CGFloat) -> NSAttributedString? {
        let currentFont = UIFont.systemFont(ofSize: fontSize)
        var activeStarFormat: [NSAttributedString.Key : Any] = [:]
        activeStarFormat = [
            NSAttributedString.Key.font: currentFont,
            NSAttributedString.Key.foregroundColor: UIColor.blueAppColor
        ]
        
        var inactiveStarFormat: [NSAttributedString.Key : Any] = [:]
        inactiveStarFormat = [
            NSAttributedString.Key.font: currentFont,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ]
        
        let starString = NSMutableAttributedString()
        
        for i in 0..<totalNumberOfStars {
            if rating >= CGFloat(i + 1) {
                starString.append(NSAttributedString(string: "\u{22C6} ", attributes: activeStarFormat as [NSAttributedString.Key : Any]))
            } else if rating > CGFloat(i) {
                starString.append(NSAttributedString(string: "\u{E1A1} ", attributes: activeStarFormat as [NSAttributedString.Key : Any]))
            } else {
                starString.append(NSAttributedString(string: "\u{22C6} ", attributes: inactiveStarFormat as [NSAttributedString.Key : Any]))
            }
        }
        return starString
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

extension SearchResultViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchRes?.offers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imgview = cell.viewWithTag(10) as? UIImageView
        imgview?.image = UIImage.init(named: searchRes?.offers?[indexPath.row].offerBanner ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: 176 , height: 100)
        }
        return CGSize(width: 317 , height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.unSelectedAllSortByButtons()
        appDelegateObject().startIndicator()
      //  self.tableView.scroll(to: .top, animated: false)
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            self.collectionViewExpendView.isHidden = false
            appDelegateObject().stopIndicator()
            switch indexPath.row {
            case 0:
                //            lblOffText.text = "25% REFUND"
                //            lblDealText.text = "ON BUS DELAY"
                self.collectionViewExpendView.backgroundColor = UIColor.init(red: 11.0/255.0, green: 104.0/255.0, blue: 150.0/255.0, alpha: 1)
                let arr = self.searchRes?.travelDetails?.filter({ (td1) -> Bool in
                    return  td1.refund == "1"
                })
                self.searchRes?.travelDetails = arr
                self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
                    return  (td1.refund ?? "") > (td2.refund ?? "")
                })
                self.tableView.reloadData()
            case 1:
                //            lblOffText.text = "UP TO 10% OFF ON"
                //            lblDealText.text = "TOP RATED BUS"
                //self.collectionViewExpendView.backgroundColor = UIColor.init(red: 92.0/255.0, green: 143.0/255.0, blue: 91.0/255.0, alpha: 1)
                self.collectionViewExpendView.backgroundColor = UIColor.init(red: 11.0/255.0, green: 104.0/255.0, blue: 150.0/255.0, alpha: 1)

                let arr = self.searchRes?.travelDetails?.filter({ (td1) -> Bool in
                    return  td1.topRatedBus == "1"
                })
                self.searchRes?.travelDetails = arr
                self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
                    return (td1.topRatedBus ?? "") > (td2.topRatedBus ?? "")
                })
                self.tableView.reloadData()
                
            case 2:
                //            lblOffText.text = "UP TO 20% OFF"
                //            lblDealText.text = "TEY NEW BUS OPERATORS"
                //self.collectionViewExpendView.backgroundColor = UIColor.init(red: 144.0/255.0, green: 137.0/255.0, blue: 82.0/255.0, alpha: 1)
                self.collectionViewExpendView.backgroundColor = UIColor.init(red: 11.0/255.0, green: 104.0/255.0, blue: 150.0/255.0, alpha: 1)

                let arr = self.searchRes?.travelDetails?.filter({ (td1) -> Bool in
                    return  td1.newOperator == "1"
                })
                self.searchRes?.travelDetails = arr
                self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
                    return  (td1.newOperator ?? "") > (td2.newOperator ?? "")
                })
                self.tableView.reloadData()
            case 3:
                //            lblOffText.text = "25% REFUND"
                //            lblDealText.text = "ON BUS DELAY"
                self.collectionViewExpendView.backgroundColor = UIColor.init(red: 11.0/255.0, green: 104.0/255.0, blue: 150.0/255.0, alpha: 1)
                let arr = self.searchRes?.travelDetails?.filter({ (td1) -> Bool in
                    return  td1.refund == "1"
                })
                self.searchRes?.travelDetails = arr
                self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
                    return  (td1.refund ?? "") > (td2.refund ?? "")
                })
                self.tableView.reloadData()
            case 4:
                //            lblOffText.text = "UP TO 10% OFF ON"
                //            lblDealText.text = "TOP RATED BUS"
                //self.collectionViewExpendView.backgroundColor = UIColor.init(red: 92.0/255.0, green: 143.0/255.0, blue: 91.0/255.0, alpha: 1)
                self.collectionViewExpendView.backgroundColor = UIColor.init(red: 11.0/255.0, green: 104.0/255.0, blue: 150.0/255.0, alpha: 1)

                let arr = self.searchRes?.travelDetails?.filter({ (td1) -> Bool in
                    return  td1.topRatedBus == "1"
                })
                self.searchRes?.travelDetails = arr
                self.searchRes?.travelDetails?.sort(by: { (td1, td2) -> Bool in
                    return (td1.topRatedBus ?? "") > (td2.topRatedBus ?? "")
                })
                self.tableView.reloadData()
            default:
                self.collectionViewExpendView.backgroundColor = UIColor.init(red: 16.0/255.0, green: 99.0/255.0, blue: 221.0/255.0, alpha: 1)
            }
            self.lblTotalBusFound.text = "\(self.searchRes?.travelDetails?.count ?? 0) Buses found"
        }
        
    }
    
}

extension SearchResultViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchRes?.travelDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultTableViewCell
        let data = searchRes?.travelDetails?[indexPath.row]
        
        cell.lblTravelName.text = data?.travelName
        cell.lblTime.text = data?.departureTime
        cell.lblRating.attributedText = (self.star(withRating: CGFloat.init(Float.init(data?.averageRating ?? "0") ?? 0), outOfTotal:  Int(data?.averageRating ?? "0") ?? 0, withFontSize: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 25) ?? NSMutableAttributedString())
        cell.lblRating.letterSpace = -5
        cell.busInfo.text = data?.busInfo
        cell.lblRatingCount.text = (data?.countRatings ?? "") + " ratings"
        cell.lblBusDetailTimeSeatStop.text = "\(data?.busSets ?? "") seats | \(data?.journeyTime ?? "") hrs | \(data?.busStop ?? "") rest stop"
        cell.lblPrice.text = "From \(currencySign)\(data?.travelPrice ?? "")"
        if let dis = data?.offerText, dis != "" {
            cell.lblDiscontOffer.text = dis
            cell.topViewHeightConstraint.constant =  UIDevice.current.userInterfaceIdiom == .pad ? 35 : 25
        } else {
            cell.topViewHeightConstraint.constant =  0
        }
        if selectedItemId?.id == data?.id {
            cell.topPrentView.layer.borderWidth = 1
            cell.imgRedioButton.image = #imageLiteral(resourceName: "Radiobutton selected")
            cell.topPrentView.layer.borderColor = UIColor.blueAppColor.cgColor
            cell.topPrentView.layer.masksToBounds = true
        } else {
            cell.imgRedioButton.image = #imageLiteral(resourceName: "Radiobutton unselected")
            cell.topPrentView.layer.borderWidth = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = searchRes?.travelDetails?[indexPath.row]
        selectedItemId = data
        tableView.reloadData()
    }
    
}

extension UIViewController {
    
    func showToast(message : String) {
       Toast.show(message: message, controller: self)
    }
}

class Toast {
    static func show(message: String, controller: UIViewController) {
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 5;
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.init(name: RobotoFontFamily.RobotoRegular.rawValue, size: 15)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 5)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -5)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -5)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 5)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let horizontalConstraint = NSLayoutConstraint(item: toastContainer, attribute: .centerX, relatedBy: .equal, toItem: controller.view, attribute: .centerX, multiplier: 1, constant: 0)
       let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: 65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -75)
        controller.view.addConstraints([c1, c2, horizontalConstraint, c3])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}

