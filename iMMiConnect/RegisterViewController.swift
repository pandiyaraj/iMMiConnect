//
//  RegisterViewController.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 14/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var popupTableView : UITableView!
    @IBOutlet weak var transparentView : UIView!
    @IBOutlet weak var popupView: UIView!
    var popUpListArray = [String]()
    var registrationType : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo iMMi Life Connect"
        popUpListArray = ["Imminent","Routine","Camp"/*,Wellness*/]
        self.popupTableView.register(UINib(nibName : Constants.NibNames.Popuptableviewcell , bundle : nil), forCellReuseIdentifier: Constants.CellIdentifier.Popuptableviewcell)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.transparentView.isHidden = false
        self.popupView.isHidden = false
        self.view.bringSubview(toFront: self.transparentView)
        self.view.bringSubview(toFront: self.popupView)
        self.transparentView.sendSubview(toBack: self.transparentView)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSaveAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBackAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - TableView DataSource and Delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == popupTableView{
            return popUpListArray.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == popupTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.Popuptableviewcell) as! PopUpTableViewCell
            cell.titleLbl.text = popUpListArray[indexPath.row]
            cell.imageView?.image = UIImage(named: "circle_unchked")
            cell.titleLbl.textAlignment = .left

            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.Popuptableviewcell) as! PopUpTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == popupTableView{
            registrationType = popUpListArray[indexPath.row]
            self.loadRegisterValues()
        }
    }
    
    func loadRegisterValues() -> Void {
        self.popupView.isHidden = true
        self.transparentView.isHidden = true
        if registrationType == "Imminent"{
            
        }else if registrationType == "Routine"{
            
        }else if registrationType == "Camp"{
            
        }else{
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == popupTableView
        {
            return 44
        }else{
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if tableView == popupTableView{
//            return "Select Registration type"
//        }else{
//            return ""
//        }
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 5, width: view.frame.size.width, height: 40)
        label.text = "Select Registration type"
        label.font = AppFont.getBold(pixels: 36)
        label.textColor = UIColor.black
        headerView.addSubview(label)
        return headerView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}
