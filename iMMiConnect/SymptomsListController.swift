//
//  SymptomsListController.swift
//  iMMiConnect
//
//  Created by Pandiyaraj on 18/12/17.
//  Copyright © 2017 Pandiyaraj. All rights reserved.
//

import UIKit

class SymptomsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var sections = sectionsData
    var completionHandler:(([String])->())!

    @IBOutlet var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Symptoms"
        self.tableView.register(UINib(nibName : Constants.NibNames.ExpandbleTableViewCell , bundle : nil), forCellReuseIdentifier: Constants.CellIdentifier.Expandablecell)
        self.tableView.register(UINib(nibName : Constants.NibNames.RemarksViewCell , bundle : nil), forCellReuseIdentifier: Constants.CellIdentifier.Remarkcell)

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK :- Tableview data source and delegate methods
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count + 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == sections.count {
            return 1
        }else{
            return sections[section].collapsed ? 0 : sections[section].items.count
            
        }
    }
    
    // Cell
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == sections.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.Remarkcell) as! RemarksViewCell
            cell.textView.text = "Remarks"
            cell.textView.delegate = self
            return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ExpandbleTableViewCell
        let item: Item = sections[indexPath.section].items[indexPath.row]
        cell.titleLabel.text = item.name
        if item.isSelected == false{
            cell.checkBoxImageView.image = UIImage.init(named: "circle_unchked")
        }else{
            cell.checkBoxImageView.image = UIImage.init(named: "circle_chkd")
        }
        return cell
        }
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == sections.count {
            return 100
        }else{
        return UITableViewAutomaticDimension
        }
    }
    
    
    // Header
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
     {
        if section == sections.count{
            return UIView()
        }else{
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
        }
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == sections.count{
            return 15
        }else{
        return 44.0
        }
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == sections.count{
        }else{
        var item: Item = sections[indexPath.section].items[indexPath.row]
        item.isSelected = !item.isSelected
        sections[indexPath.section].items[indexPath.row] = item
        self.tableView.reloadData()
        }
    }
    
    @IBAction func onSaveAction() -> Void {
        var symtoms = [String]()
        var selectedSymptomObjects = [Item]()
        for selectedSymptoms in sections{
            selectedSymptomObjects = selectedSymptoms.items.filter({ (item) -> Bool in
                return item.isSelected == true
            })
            for symptomName in selectedSymptomObjects{
                symtoms.append(symptomName.name)
            }
            
        }
        if symtoms.count > 0{
            self.completionHandler(symtoms)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.showAlert(title: "Error", contentText: "Please select any symptoms", actions: nil)
        }
       
    }

}

extension SymptomsListController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
    
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}

extension SymptomsListController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray || textView.text == "Remarks"{
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
        let cell = textView.superview!.superview as! RemarksViewCell
        let indexpath = self.tableView.indexPath(for: cell)
        self.tableView.scrollToRow(at: indexpath!, at: .top, animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text.trimmed.count == 0 {
            textView.text = "Remarks"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
}

//MARK: Data Loading
//public struct Item {
//    var name: String
//    //    var detail: String
//    var isSelected : Bool
//    public init(name: String,isSelected: Bool) {
//        self.name = name
//        //        self.detail = detail
//        self.isSelected = isSelected
//    }
//}
//
//public struct Section {
//    var name: String
//    var items: [Item]
//    var collapsed: Bool
//
//    public init(name: String, items: [Item], collapsed: Bool = false) {
//        self.name = name
//        self.items = items
//        self.collapsed = collapsed
//    }
//}
//
//public var sectionsData: [Section] = [
//    Section(name: "Chest pain or Discomfort", items: [
//
//        Item(name: "Centre or left side of the chest lasting more than a few minutes", isSelected: false),
//        Item(name: "Sometimes disappears and comes back", isSelected: false),
//        Item(name: "Pressure, squeezing, fullness or pain", isSelected: false),
//        Item(name: "Feels like heart burn or indigestion", isSelected: true),
//        Item(name: "Radiates to the left shoulder or left arm or jaw or back of the chest or in-between the shoulder blades and sometimes to the right shoulder", isSelected: true),
//        Item(name: "Pain in the upper stomach", isSelected: false)
//        ], collapsed : false),
//    Section(name: "Breathlessness", items: [
//        Item(name: "Associated with chest pain", isSelected: false),
//        Item(name: "Without chest pain", isSelected: false),
//        Item(name: "Occurs at rest", isSelected: false),
//        Item(name: "Occurs with some physical activity", isSelected: false)
//        ], collapsed : true),
//    Section(name: "Others", items: [
//        Item(name: "Sweating and excessive tiredness-cold sweat", isSelected: false),
//        Item(name: "Nausea and/or vomiting", isSelected: false),
//        Item(name: "Light headedness or dizziness", isSelected: false),
//        Item(name: "Anxiety or 'fear of impendingdoom", isSelected: false),
//        Item(name: "Cough or wheeze", isSelected: false),
//        Item(name: "Irregular heart bear causing palpitation and irregular pulse", isSelected: false)
//        ], collapsed : true)
//]

