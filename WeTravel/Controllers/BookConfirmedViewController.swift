//
//  BookConfirmedViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit

class BookConfirmedViewController: UIViewController {

    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblStatusConfirmed: UILabel!
    var isComeFromMyTickets = false
    
    var bannerImage: MyTicketResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "recommandations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                self.bannerImage = try jsonDecoder.decode(MyTicketResponse.self, from: data)
            } catch {
                // handle error
            }
        }
        
        lblStatusConfirmed.text = "Status Confirmed | \(currencySign)810"
        self.tableView.isHidden = true
        appDelegateObject().startIndicator()
        DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
            appDelegateObject().stopIndicator()
            self.tableView.isHidden = false
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            btnDone.layer.cornerRadius = 33
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonCLick(_ sender: Any) {
        if isComeFromMyTickets {
           self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
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

extension BookConfirmedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bannerImage?.recommendations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let imgView = cell.viewWithTag(10) as? UIImageView
        let data = bannerImage?.recommendations?[indexPath.row]
        imgView?.image = UIImage.init(named: data?.banner ?? "")
        return cell
    }
    
    
}
