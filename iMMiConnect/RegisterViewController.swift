//
//  RegisterViewController.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 14/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit
import AVFoundation

enum RegistrationType : String {
    case Imminent = "Imminent"
    case Routine = "Routine"
    case Camp = "Camp"
}
class RegisterViewController: UIViewController {

    @IBOutlet weak var popupTableView : UITableView!
    @IBOutlet weak var transparentView : UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var symptomsButton : UIButton!
    @IBOutlet weak var cameraButton : UIButton!
   
    @IBOutlet weak var symptomsViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var ecgViewTopConstraint : NSLayoutConstraint!
    @IBOutlet weak var ecgViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var ecgThumbImage : UIImageView!

    var popUpListArray = [String]()
    var registrationType : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo iMMi Life Connect"
        popUpListArray = ["Imminent","Routine","Camp"/*,Wellness*/]
        self.popupTableView.register(UINib(nibName : Constants.NibNames.Popuptableviewcell , bundle : nil), forCellReuseIdentifier: Constants.CellIdentifier.Popuptableviewcell)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        
        self.transparentView.isHidden = false
        self.popupView.isHidden = false
        self.view.bringSubview(toFront: self.transparentView)
        self.view.bringSubview(toFront: self.popupView)
        self.transparentView.sendSubview(toBack: self.transparentView)
        
        self.ecgViewTopConstraint.constant = 80
        self.symptomsViewHeightConstraint.constant = 140
        self.ecgViewTopConstraint.constant = self.symptomsViewHeightConstraint.constant + 20
        self.ecgThumbImage.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    

    
    @IBAction func symptomsButtonAction() -> Void{
        let symptomsVc = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerNames.SymptomsVc) as! SymptomsListController
        self.navigationController?.pushViewController(symptomsVc, animated: true)
        symptomsVc.completionHandler = {(seletedSymptoms) in
            print(seletedSymptoms)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSaveAction() -> Void {
//        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBackAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadRegisterValues() -> Void {
        self.popupView.isHidden = true
        self.transparentView.isHidden = true
     
        if registrationType == RegistrationType.Imminent.rawValue{
            
        }else if registrationType == RegistrationType.Routine.rawValue{
            
        }else if registrationType == RegistrationType.Camp.rawValue{
//            self.getCampNames
        }else{
            
        }
    }
    
    
    func getCampNames() -> Void {
        // Fetch camp names from server
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    // MARK:- Camera Action sheet Methods
    @IBAction func cameraButtonAction() -> Void{
        let cameraActionShett: UIAlertController = UIAlertController(title:"Message", message: "Choose image from", preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        cameraActionShett.addAction(cancelActionButton)
        
        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default)
        { action -> Void in
            let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
            switch authStatus {
            case .authorized:
                self.openCameraContoller(status: 0)
            case .denied:
                self.alertPromptToAllowCameraAccessViaSetting()
            default:
                self.openCameraContoller(status: 0)
            }
            
        }
        if !Constants.DeviceType.IS_SIMULATOR {
            cameraActionShett.addAction(cameraAction)
        }
        
        let galerryAction: UIAlertAction = UIAlertAction(title: "Gallery", style: .default)
        { action -> Void in
            self.openCameraContoller(status: 1)
        }
        cameraActionShett.addAction(galerryAction)
        self.present(cameraActionShett, animated: true, completion: nil)
        
    }
    
    func openCameraContoller(status : Int) -> Void {
        let vc = CameraViewController().initWithController() as! CameraViewController
        vc.openCamera(status)
        self.navigationController?.present(vc, animated: false, completion: { _ in })
        vc.completionHandler = {(_ obj: Any?) -> Void in
            if obj != nil {
                if (obj is UIImage) {
                   
                    DispatchQueue.main.async {
                        let profileImage = obj as? UIImage
                        self.ecgThumbImage.image = profileImage
                        self.ecgThumbImage.isHidden = false
                        self.ecgViewHeightConstraint.constant = 120
                    }
                }
            }
            DispatchQueue.main.async(execute: {() -> Void in
                self.dismiss(animated: false, completion: { _ in })
            })
        }
    }
    
    
    
    func alertPromptToAllowCameraAccessViaSetting() {
        let alert = UIAlertController(title: "Error", message: "Camera access required to change in settings...", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
        })
        
        present(alert, animated: true)
    }
    
}

extension RegisterViewController : UITableViewDelegate,UITableViewDataSource{
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
            cell.cellImageView?.image = UIImage(named: "circle_unchked")
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
}
