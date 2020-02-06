//
//  CustumDropDownViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit

class CustumDropDownViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var perentView: UIView!
    @IBOutlet weak var viewPrentOfTable: UIView!
    @IBOutlet weak var tableView: UITableView!
    var didSelect: ((Cities?, Int?) -> Void)?
    var arrDropDownData : [Cities]?
    var textField : UITextField!
    private var holdVal : [Cities]?
    var textFeldDidChangeStart = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        holdVal = arrDropDownData
        if textFeldDidChangeStart {
            textField?.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            self.textFieldDidChange(textField)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.perentView.backgroundColor = UIColor.clear
            self.perentView.layer.shadowColor = UIColor.black.cgColor
            self.perentView.layer.shadowOffset = CGSize(width: 1, height: 1)
            self.perentView.layer.shadowOpacity = 0.2
            self.perentView.layer.shadowRadius = 4.0
            self.perentView.layer.masksToBounds = false
        }
        self.heightCalculate()

    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        arrDropDownData = holdVal?.filter({ (city) -> Bool in
            return city.city_name?.lowercased().contains(textField.text?.lowercased() ?? "") ?? false
        })
        if textField.text?.count == 0 {
            arrDropDownData = holdVal
        }
        self.heightCalculate()
        self.view.isHidden = arrDropDownData?.count == 0
        tableView.reloadData()
    }
    
    func heightCalculate() {
        self.view.frame.size.height = (CGFloat((arrDropDownData?.count ?? 0)) * CGFloat.init(44)) < self.view.frame.width ? (CGFloat((arrDropDownData?.count ?? 0)) * CGFloat.init(44)) : self.view.frame.width

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDropDownData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrDropDownData?[indexPath.row].city_name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let comp = didSelect {
            comp(arrDropDownData?[indexPath.row], indexPath.row)
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
