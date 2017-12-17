//
//  DashboardViewController.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 13/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var versionLabel : UILabel!
    @IBOutlet weak var noPatientLabel : UILabel!
    var patientArrayList = [Dictionary<String,Any>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.black,
             NSFontAttributeName: AppFont.getBold(pixels: 40)]
        self.title = "Demo iMMi Life Connect"
        self.tableView.tableFooterView = UIView()
        userNameLabel.text =  "Test"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPatientDetails() -> Void {
        if patientArrayList.count == 0{
            userNameLabel.isHidden = false
            tableView.isHidden = true
        }else{
            userNameLabel.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    @IBAction func registerPatientAction() -> Void{
        let dashboardVc = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerNames.RegisterPatientVc) as! RegisterViewController
        self.navigationController?.pushViewController(dashboardVc, animated: true)
    }

    // MARK: - Tableview data source and delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  == 0{
        let dashboardVc = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerNames.PatientListVc) as! PatientListViewController
        self.navigationController?.pushViewController(dashboardVc, animated: true)
        }
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
