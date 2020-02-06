//
//  SeatSelectionViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit

class SeatSelectionViewController: UIViewController {

    @IBOutlet weak var imgRightArrow: UIImageView!
    @IBOutlet weak var btnFindBus: UIButton!
    @IBOutlet weak var lblDealsTexts: UILabel!
    @IBOutlet weak var lblDeals: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSeatNumbers: UILabel!
    @IBOutlet weak var btn550: UIButton!
    @IBOutlet weak var btn399: UIButton!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var lblTravelType: UILabel!
    @IBOutlet weak var blTravelDateTime: UILabel!
    @IBOutlet weak var lblTravelName: UILabel!
    @IBOutlet weak var lowerViewSelected: UIView!
    @IBOutlet weak var uperViewSelected: UIView!
    @IBOutlet weak var btnUpper: UIButton!
    @IBOutlet weak var btnLower: UIButton!
    @IBOutlet weak var seatPerentView: UIView!
    @IBOutlet weak var btnButtomSheetOpenClose: UIButton!
    @IBOutlet weak var heightConstrainOfExpendButtomView: NSLayoutConstraint!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var isLowerSelected = true
    fileprivate var seatingRes : SeatingResponse?
    var selectedTravelDetail : TravelDetails?
    var travelDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPrice.text = "\(currencySign)0"
        btn399.setTitle("\(currencySign)399", for: .normal)
        btn550.setTitle("\(currencySign)550", for: .normal)
        lowerButtonSelected(isSelected: true)
        if let path = Bundle.main.path(forResource: "seating", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                self.seatingRes = try jsonDecoder.decode(SeatingResponse.self, from: data)
            } catch {
                // handle error
            }
        }
        if let data = selectedTravelDetail {
            lblTravelName.text = data.travelName
            blTravelDateTime.text = "\(travelDate ?? "") | \(data.departureTime ?? "")"
            lblTravelType.text = data.busInfo
        }
        self.seatPerentView.isHidden = true
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
            self.seatPerentView.isHidden = false
        }
        seatTypeIsLower(isLower: true)
        btnAll.isSelected = true
        self.findButtonManage(isBlue: false)
    }

    
    // MARK: - IBActions
    @IBAction func lowerButtonClick(_ sender: Any) {
        lowerButtonSelected(isSelected: true)
        seatTypeIsLower(isLower: true)
        isLowerSelected = true
    }
    
    @IBAction func upperButtonClick(_ sender: Any) {
      lowerButtonSelected(isSelected: false)
        seatTypeIsLower(isLower: false)
        isLowerSelected = false
    }
    
    private func lowerButtonSelected(isSelected : Bool) {
        btnLower.isSelected = !isSelected
        btnUpper.isSelected = isSelected
        lowerViewSelected.isHidden = !isSelected
        uperViewSelected.isHidden = isSelected
    }
    
    @IBAction func findBusButtonClick(_ sender: Any) {
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    @IBAction func buttonSheetOpenCloseButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.heightConstrainOfExpendButtomView.constant = sender.isSelected ? 231 : 60
        UIView.animate(withDuration: 0.3) {
            self.btnArrow.transform = sender.isSelected ? CGAffineTransform(rotationAngle: -CGFloat.pi) : CGAffineTransform.identity
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func backButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seatClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if isLowerSelected
        {
            if let index =  seatingRes?.seatsLower?.firstIndex(where: { (seat) -> Bool in
                return seat.id == "\(sender.tag)"
            }) {
                seatingRes?.seatsLower?[index].isSelected = sender.isSelected
            
            }
        } else {
            if let index =  seatingRes?.seatsUpper?.firstIndex(where: { (seat) -> Bool in
                return seat.id == "\(sender.tag)"
            }) {
                seatingRes?.seatsUpper?[index].isSelected = sender.isSelected
                
            }
        }
        findTotalSeatAndPrice()
    }
    
    @IBAction func allSeatButtonClick(_ sender: UIButton) {
        self.lowerButtonSelected(isSelected: isLowerSelected)
        seatTypeIsLower(isLower: isLowerSelected)
        sender.isSelected = true
        btn399.isSelected = false
        btn550.isSelected = false
        isLowerSelected ? seatTypeByPriceLower(seat: sender) : seatTypeByPriceUper(seat: sender)
    }
    
    @IBAction func Button399Click(_ sender: UIButton) {
        btnAll.isSelected = false
        btn399.isSelected = true
        btn550.isSelected = false
        isLowerSelected ? seatTypeByPriceLower(seat: sender) : seatTypeByPriceUper(seat: sender)
    }
    
    @IBAction func Button550Click(_ sender: UIButton) {
        btnAll.isSelected = false
        btn399.isSelected = false
        btn550.isSelected = true
        isLowerSelected ? seatTypeByPriceLower(seat: sender) : seatTypeByPriceUper(seat: sender)
    }
    
    // MARK: - Custom Methods
    func findTotalSeatAndPrice()  {
        var strNumber = ""
        var price = 0
        var seatCount = 0
       // if isLowerSelected {
            if let rest =  seatingRes?.seatsLower?.filter({ (seat) -> Bool in
            return seat.isSelected ?? false
          }) {
            for item in rest {
                strNumber += "L" + (item.id ?? "") + ","
                price += Int(item.price ?? "0") ?? 0
                seatCount += 1
            }
            }
       // } else {
            if let rest =  seatingRes?.seatsUpper?.filter({ (seat) -> Bool in
                return seat.isSelected ?? false
            }) {
                for item in rest {
                    strNumber += "U" + (item.id ?? "") + ","
                    price += Int(item.price ?? "0") ?? 0
                    seatCount += 1
                }
            }
       // }
        if seatCount > 1 {
            for item in (seatingRes?.dealOffer ?? []).enumerated() {
                var itemActualPrice = 0
                if item.element.id == "1" {
                    itemActualPrice = 50
                } else if item.element.id == "2" {
                    itemActualPrice = 210
                } else if item.element.id == "3" {
                    itemActualPrice = 50
                } else if item.element.id == "4" {
                    itemActualPrice = 210
                }
                let price = itemActualPrice * seatCount
                seatingRes?.dealOffer?[item.offset].dealPrice = "\(price)"
            }
            self.tableView.reloadData()
        }
        
        if let deals = seatingRes?.dealOffer?.filter({ (deal) -> Bool in
            return deal.isSelected ?? false
        }) {
            var total = 0
            for item in deals {
                total += Int(item.dealPrice ?? "") ?? 0
            }
            price += total
            lblDeals.text = total > 0 ? "(Including \(total) Rs Deals)" : ""
            lblDealsTexts.text = (deals.count > 0 ? "Added \(deals.count) deals" : "Add on Deals for extra pillow, snacks to make your journey rock!")
        }
        if !strNumber.isEmpty {
            strNumber.removeLast()
        }
        findButtonManage(isBlue: seatCount > 0)
        lblPrice.text = "\(currencySign)\(price)"
        lblSeatNumbers.text = strNumber
    }
    
    func seatTypeIsLower(isLower : Bool) {
        if isLower {
            for item in self.seatingRes?.seatsLower ?? []  {
                if let btn = seatPerentView.viewWithTag(Int(item.id ?? "0") ?? 0) as? UIButton {
                    if item.status == "0" {
                        btn.isSelected = false
                        btn.isEnabled = true
                    } else {
                        btn.isSelected = false
                        btn.isEnabled = false
                    }
                    if item.isSelected ?? false {
                        btn.isEnabled = true
                        btn.isSelected = true
                    }
                    
                }
            }
        } else {
            for item in self.seatingRes?.seatsUpper ?? []  {
                if let btn = seatPerentView.viewWithTag(Int(item.id ?? "0") ?? 0) as? UIButton {
                    if item.status == "0" {
                        btn.isSelected = false
                        btn.isEnabled = true
                    } else {
                        btn.isSelected = false
                        btn.isEnabled = false
                    }
                    if item.isSelected ?? false {
                        btn.isEnabled = true
                        btn.isSelected = true
                    }
                }
            }
        }
    }
    
    func seatTypeByPriceLower(seat: UIButton) {
        var arr  = [SeatsLower]()
        if btnAll.isSelected {
            arr = seatingRes?.seatsLower ?? []
        } else if btn399.isSelected {
            arr = seatingRes?.seatsLower?.filter({ (seat) -> Bool in
                return seat.price == "399"
            }) ?? []
        } else if btn550.isSelected {
            arr = seatingRes?.seatsLower?.filter({ (seat) -> Bool in
                return seat.price == "550"
            }) ?? []
        }
        self.allSeatDisable()
        for item in arr  {
            if let btn = seatPerentView.viewWithTag(Int(item.id ?? "0") ?? 0) as? UIButton {
                if item.status == "0" {
                    btn.isSelected = false
                    btn.isEnabled = true
                } else {
                    btn.isSelected = false
                    btn.isEnabled = false
                }
                if item.isSelected ?? false {
                    btn.isEnabled = true
                    btn.isSelected = true
                }
                btn.alpha = 1
            }
        }
    }
    
    func seatTypeByPriceUper(seat: UIButton) {
        var arr  = [SeatsUpper]()
        if btnAll.isSelected {
            arr = seatingRes?.seatsUpper ?? []
        } else if btn399.isSelected {
            arr = seatingRes?.seatsUpper?.filter({ (seat) -> Bool in
                return seat.price == "399"
            }) ?? []
        } else if btn550.isSelected {
            arr = seatingRes?.seatsUpper?.filter({ (seat) -> Bool in
                return seat.price == "550"
            }) ?? []
        }
        self.allSeatDisable()
        for item in arr  {
            if let btn = seatPerentView.viewWithTag(Int(item.id ?? "0") ?? 0) as? UIButton {
                if item.status == "0" {
                    btn.isSelected = false
                    btn.isEnabled = true
                } else {
                    btn.isSelected = false
                    btn.isEnabled = false
                }
                if item.isSelected ?? false {
                    btn.isEnabled = true
                    btn.isSelected = true
                }
                btn.alpha = 1
            }
        }
    }
    
    func allSeatDisable() {
        for item in 1...23 {
            if let btn = seatPerentView.viewWithTag(item) as? UIButton {
                btn.isEnabled = false
                btn.alpha = 0
            }
        }
    }
    
    private func findButtonManage(isBlue : Bool) {
        if isBlue {
            btnFindBus.backgroundColor = UIColor.blueAppColor
           // imgRightArrow.image = #imageLiteral(resourceName: "RightArrow")
            btnFindBus.setTitleColor(UIColor.white, for: .normal)
        } else {
            btnFindBus.backgroundColor = UIColor.init(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1)
          //  imgRightArrow.image = #imageLiteral(resourceName: "disableArrow")
            btnFindBus.setTitleColor(UIColor.lightGray, for: .normal)
        }
        btnFindBus.isEnabled = isBlue
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

extension SeatSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seatingRes?.dealOffer?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let imgOffer = cell.viewWithTag(50) as? UIImageView
        let lblOffer = cell.viewWithTag(51) as? UILabel
        let imgAddAndCross = cell.viewWithTag(52) as? UIImageView
        let data = seatingRes?.dealOffer?[indexPath.row]
        imgAddAndCross?.image = data?.isSelected ?? false ? #imageLiteral(resourceName: "offer remove icon") : #imageLiteral(resourceName: "offer add icon")

        imgOffer?.image = UIImage.init(named: data?.dealImage ?? "")
        let strDealText = "\(data?.dealName ?? "") for just \(currencySign)\(data?.dealPrice ?? "")"
        if let renge = strDealText.range(of: "for just") {
            let nsRange = strDealText.nsRange(from: renge)
            let amountText = NSMutableAttributedString.init(string: strDealText)
            amountText.setAttributes([NSAttributedString.Key.font: UIFont.init(name: RobotoFontFamily.RobotoRegular.rawValue, size: UIDevice.current.userInterfaceIdiom == .pad ? 13 : 10) ?? UIFont.systemFont(ofSize: 10),
                                      NSAttributedString.Key.foregroundColor: UIColor.lightGray],
                                     range: nsRange)
            lblOffer?.attributedText = amountText
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bools = seatingRes?.dealOffer?[indexPath.row].isSelected
        seatingRes?.dealOffer?[indexPath.row].isSelected = !(bools ?? false)
        self.tableView.reloadData()
        self.findTotalSeatAndPrice()
    }
    
}

extension StringProtocol {
    func nsRange(from range: Range<Index>) -> NSRange {
        return .init(range, in: self)
    }
}

