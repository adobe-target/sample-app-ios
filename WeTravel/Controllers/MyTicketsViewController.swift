//
//  MyTicketsViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit

class MyTicketsViewController: UIViewController {
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var btnComplete: UIButton!
    @IBOutlet weak var buttomViewUpcoming: UIView!
    @IBOutlet weak var buttomViewComplete: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewTab: UIView!

    var myTcket: MyTicketResponse?
    var holdData: MyTicketResponse?
    var numberOfRows = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "my_tickets", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                self.myTcket = try jsonDecoder.decode(MyTicketResponse.self, from: data)
                self.holdData = self.myTcket
            } catch {
                // handle error
            }
        }
        self.scrollView.isHidden = true
        self.viewTab.isHidden = true
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
            self.scrollView.isHidden = false
            self.viewTab.isHidden = false
        }
        self.upcomingOrComplete(isUpcoming: true)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "sidemenu", sender: self)
    }
    
    @IBAction func upcomingButtonClick(_ sender: Any) {
        buttomViewComplete.isHidden = true
        buttomViewUpcoming.isHidden = false
        self.upcomingOrComplete(isUpcoming: true)
    }
    @IBAction func completeButtonClick(_ sender: Any) {
        buttomViewComplete.isHidden = false
        buttomViewUpcoming.isHidden = true
        self.upcomingOrComplete(isUpcoming: false)
    }
    
    func upcomingOrComplete(isUpcoming : Bool)  {
        let formator = DateFormatter()
        formator.dateFormat = "dd-MM-yyyy"
        formator.timeZone = TimeZone(abbreviation: "UTC")!
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        comp.timeZone = TimeZone(abbreviation: "UTC")!
        let truncated = Calendar.current.date(from: comp)!
        print(truncated)
        
        myTcket?.ticket_history = holdData?.ticket_history?.filter({ (ticket) -> Bool in
            
            return (isUpcoming ? (formator.date(from: ticket.departure_date ?? "") ?? Date()) >= truncated: (formator.date(from: ticket.departure_date ?? "") ?? Date()) < truncated)
        })
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BookConfirmedViewController {
            vc.isComeFromMyTickets = true
        }
        if let vc = segue.destination as? SideMenuViewController {
            vc.navigationControllerIs = self.navigationController
        }
    }
    

}

extension MyTicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTcket?.ticket_history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTicketTableCell
        let data = myTcket?.ticket_history?[indexPath.row]
        cell.lblFromTo.text = (data?.departure ?? "") + " to " + (data?.destination ?? "")
        cell.lblSeatNumberAndPrice.text = "Seat Number (\(data?.seat ?? "")) | \(currencySign)\(data?.amount ?? "")"
        cell.lblTravelDetails.text = "\(data?.travel_name ?? "") (\(data?.bus_info ?? ""))"
        cell.lblDate.text = "on \(data?.departure_date ?? "")"
        cell.lblTime.text = "at \(data?.departure_time ?? "")"
        cell.lblJurneryHours.text = "For \(data?.duration ?? "") hrs"
        return cell
    }
}
// MARK: - Table Cell
class MyTicketTableCell: UITableViewCell {
    @IBOutlet weak var lblFromTo: UILabelHelper!
    @IBOutlet weak var lblSeatNumberAndPrice: UILabelHelper!
    @IBOutlet weak var lblTravelDetails: UILabelHelper!
    @IBOutlet weak var lblDate: UILabelHelper!
    @IBOutlet weak var lblTime: UILabelHelper!
    @IBOutlet weak var lblJurneryHours: UILabelHelper!
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MyTicketsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myTcket?.recommendations?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCollectionViewCell
        let data = myTcket?.recommendations?[indexPath.row]
        cell.imgBanner.image = UIImage.init(named: data?.banner ?? "")

        return cell
    }
    
    // SIZE FOR COLLECTION VIEW CELL
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
       // let screenSize = UIScreen.main.bounds
        return CGSize(width: ((view.frame.width - 30) < 400 ? (view.frame.width - 30) : 400) , height: 49 / 100 * ((view.frame.width - 20) < 400 ? (view.frame.width - 20) : 400))
      //  return CGSize.init(width: screenSize.width * (320/320), height: screenSize.height * (182/568))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
