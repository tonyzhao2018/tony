//
//  menuViewController.swift
//  mytest
//
//  Created by knuproimac on 2020-07-17.
//  Copyright © 2020 tony. All rights reserved.
//

import UIKit
class ModelMenuItem: NSObject {
    override init() {
        super.init()
    }
    var icon:String?
    var itemName:String?
    var groupID:Int?
    var itemID:Int?
    var isBeChosen:Bool! = false
}
class ModelMenuGroup: NSObject {
    override init() {
        super.init()
    }
    var icon:String?
    var name:String?
    var groupID:Int?
    func onlyForTest(_ mid:Int?) ->(){
        if let mid = mid {
            groupID = mid
        }
        groupID = 100
        print("hello everyone")
    }
}
class menuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,menuItemTableViewCellDelegate    {
// MARK: - menuViewController
    var sectionList:[String] = Array()
    //Array that store index of opened Section while running
    var itemsList: Array<Array<ModelMenuItem>>? = nil
    var collapaseHandlerArray = [String]()
    @IBOutlet weak var tvFilters: UITableView!
    
override func viewDidLoad() {
    
    super.viewDidLoad()
    retrieveData()
     tvFilters.tableFooterView=UIView()
    // tableview.estimatedRowHeight = 60
     tvFilters.rowHeight = UITableView.automaticDimension
     tvFilters.separatorInset = UIEdgeInsets.zero

     tvFilters!.register(UINib(nibName: "menuItemTableViewCell", bundle: nil), forCellReuseIdentifier: "menuItemTableViewCell")
     tvFilters!.register(UINib(nibName: "menuHeaderCell", bundle: nil), forCellReuseIdentifier: "menuHeaderCell")
     

     if let index = tvFilters.indexPathForSelectedRow{
         tvFilters.deselectRow(at: index, animated: true)
     }
     tvFilters.allowsSelectionDuringEditing = false
     tvFilters.allowsSelection = false

    // Do any additional setup after loading the view.
}

    
// MARK: - view Functions

    @objc func HandleheaderButton(sender: UIButton){
        
        //check status of button
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "+"{
                self.collapaseHandlerArray.append(self.sectionList[sender.tag])
                sender.setTitle("-", for: .normal)
            }
            else {
                while self.collapaseHandlerArray.contains(self.sectionList[sender.tag]){
                    if let itemToRemoveIndex = self.collapaseHandlerArray.firstIndex(of: self.sectionList[sender.tag]) {
                        //remove title of header from array
                        self.collapaseHandlerArray.remove(at: itemToRemoveIndex)
                        sender.setTitle("+", for: .normal)
                    }
                }
            }
        }
        //reload section
        debugPrint(sender.tag)
        self.tvFilters.reloadSections(IndexSet(integer: sender.tag), with: .none)
    }
    @objc func AddNewMenu(sender: UIButton){
        let groupTag = sender.tag
        popEdit(addMenuToLocalArr, groupTag,nil)
    }
    func addMenuToLocalArr(_ menu: String?, _ groupTag:Int?, _ itemId: Int?) -> () {
        print(menu!)
        self.collapaseHandlerArray.append(self.sectionList[groupTag!])
        debugPrint(groupTag as Any)
        let item = ModelMenuItem()
        item.itemName = menu
        item.groupID = groupTag
        let number = Int.random(in: 1000 ..< 10_000)
        item.itemID = groupTag! + number
        itemsList![groupTag!].append(item)
        let controller =  menuDataController()
        controller.insertOneMenu(item)
        self.tvFilters.reloadSections(IndexSet(integer: groupTag!), with: .none)
    }
    func updateMenuToLocalArr(_ menu: String?, _ groupTag:Int?, _ itemId: Int?) -> () {
        print(menu!)
        guard let groupTag = groupTag
            else{
                return
        }
        guard let itemId = itemId
            else{
                return
        }
        guard let menu = menu
            else{
                return
        }
        let se:Array<ModelMenuItem> = itemsList![groupTag]
        for i in 0 ..< (se.count) {
                if(se[i].itemID == itemId){
                    
                    let controller =  menuDataController()
                    self.itemsList![groupTag][i].itemName = menu
                    controller.updateOneMenu(self.itemsList![groupTag][i])
                    break
                }
            }
        self.tvFilters.reloadSections(IndexSet(integer: groupTag), with: .none)
    }
    func editTheMenu(sectionID: Int, itemId:Int, groupId:Int, isChosen:Bool){
        popEdit(updateMenuToLocalArr, sectionID, itemId)
    }
    func removeTheMenu(sectionID: Int, itemId: Int, groupId: Int, isChosen: Bool) {
        let se:Array<ModelMenuItem> = itemsList![sectionID]
        ShowALert(){
              
                for i in 0 ..< (se.count) {
                    if(se[i].itemID == itemId){
                        let controller =  menuDataController()
                        let aitem = self.itemsList![sectionID][i]
                        controller.deleteOneMenu(aitem)
                        self.itemsList![sectionID].remove(at: i)
                        
                        break
                    }
                }
            self.tvFilters.reloadSections(IndexSet(integer: sectionID), with: .none)
        }
    }
    func checkIfChosen()->Bool{
            for aList in itemsList! {
                for item in aList {
                            if(item.isBeChosen == true){
                                return true
                            }
                        }
            }
            return false
    }

// MARK: - UITableview delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Declare cell
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "menuHeaderCell") as! menuHeaderCell
        headerCell.titleLabel.text = self.sectionList[section]
        headerCell.ButtonToShowHide?.tag = section
        if self.collapaseHandlerArray.contains(self.sectionList[section]){
            headerCell.ButtonToShowHide?.setTitle("-", for: .normal)
        }
        else{
            headerCell.ButtonToShowHide?.setTitle("+", for: .normal)
        }
        headerCell.ButtonToShowHide?.addTarget(self, action: #selector(HandleheaderButton(sender:)), for: .touchUpInside)
        headerCell.btnAdd?.tag = headerCell.ButtonToShowHide!.tag
        headerCell.btnAdd?.addTarget(self, action: #selector(AddNewMenu(sender:)), for: .touchUpInside)
        return headerCell.contentView
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.collapaseHandlerArray.contains(self.sectionList[section]){
            let se:Array<ModelMenuItem> = itemsList![section]
            let iCount = se.count
            
            return iCount

        }
        else{

            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:menuItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuItemTableViewCell", for: indexPath) as! menuItemTableViewCell
        //itemsList
        let se:Array<ModelMenuItem> = itemsList![indexPath.section]

        cell.firstItem = se[indexPath.row]
        cell.firstItem?.groupID = indexPath.section
        cell.resetData()
        cell.delegate = self
      
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;
    }

// MARK: -  retrieve data from coredata
    func retrieveData(){
        itemsList = []
        let controller =  menuDataController()
        let gruoplist = controller.getMenuGroupList()
        let items = controller.getMenuItemList()
        for ai in gruoplist{
            sectionList.append(ai.name!)
            var arr = [ModelMenuItem]()
            let gid = ai.groupID
            for bi in items{
                if(bi.groupID == gid){
                    arr.append(bi)
                }
            }
            itemsList?.append(arr)
        }
    }
    //MARK: - alert view
    func popEdit(_ callback:@escaping ( _ menu:String?,_ groupTag:Int?, _ itemId: Int?)->(),_ tag:Int,_ itemId:Int?) {
        var titleText = "Edit Menu"
        var btnText = "Confirm"
        if(itemId == nil){
            titleText = "Add Menu"
            btnText = "Add"
        }
        let alert = UIAlertController(title: titleText, message: "Please input menu name", preferredStyle: UIAlertController.Style.alert )
        let save = UIAlertAction(title: btnText, style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if textField.text != "" {
                //Read TextFields text data
                print(textField.text!)
                print("menu : \(textField.text!)")
                callback(textField.text!,tag,itemId)
            } else {
              
                print("menu is Empty...")
                return
            }
        }
      
        alert.addTextField { (textField) in
            textField.placeholder = "menu name"
            textField.textColor = .black
           // textField.addTarget(self, action: "textChanged:", for: .editingChanged)
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        }
        alert.addAction(save)
      
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)

        (alert.actions[0] as UIAlertAction).isEnabled = false
       
        self.present(alert, animated:true, completion: nil)


    }
    func ShowALert(_ callback:@escaping ()->()) {
       
          let alert = UIAlertController(title: "Remove Menu", message: "Are you sure you want ro remove it?", preferredStyle: UIAlertController.Style.alert )
          let yes = UIAlertAction(title: "YES", style: .default) { (alertAction) in
              callback()
          }
        
        
          alert.addAction(yes)
        
          let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
          alert.addAction(cancel)
         
          self.present(alert, animated:true, completion: nil)
      

      }
    @objc func textChanged (sender:AnyObject) {
               let tf = sender as! UITextField
               var resp : UIResponder = tf
               while !(resp is UIAlertController) { resp = resp.next! }
               let alert = resp as! UIAlertController
               (alert.actions[0] as UIAlertAction).isEnabled = (tf.text != "")
           }




    }
