//
//  menuItemTableViewCell.swift
//
//  Created by knuproimac on 2020-07-18.
//  Copyright © 2019 tony. All rights reserved.
//

import UIKit

protocol menuItemTableViewCellDelegate {
    func removeTheMenu(sectionID: Int, itemId:Int, groupId:Int, isChosen:Bool)
    func editTheMenu(sectionID: Int, itemId:Int, groupId:Int, isChosen:Bool)
}

class menuItemTableViewCell: UITableViewCell {
    var firstItem:ModelMenuItem?

    var delegate:menuItemTableViewCellDelegate?
    @IBOutlet weak var lblMenuTitle: UILabel?
    @IBOutlet weak var btnEdit: UIButton?
    @IBOutlet weak var btnRemove: UIButton?
    @objc func RemoveIt(sender: UIButton){
      reloadBtn(btn: lblMenuTitle!, item: firstItem!)
   
      delegate?.removeTheMenu(sectionID: firstItem!.groupID!, itemId: firstItem!.itemID!, groupId: firstItem!.groupID!, isChosen: firstItem!.isBeChosen!)
      }
    @objc func EditIt(sender: UIButton){
       reloadBtn(btn: lblMenuTitle!, item: firstItem!)
       delegate?.editTheMenu(sectionID: firstItem!.groupID!, itemId: firstItem!.itemID!, groupId: firstItem!.groupID!, isChosen: firstItem!.isBeChosen!)
       }
    override func awakeFromNib() {
        super.awakeFromNib()
        btnRemove?.addTarget(self, action: #selector(RemoveIt(sender:)), for: .touchUpInside)
        btnEdit?.addTarget(self, action: #selector(EditIt(sender:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func resetData(){
        var leftText:String? = nil
        if((firstItem) != nil){
            leftText = firstItem?.itemName
        }
        else{
            return
        }
        lblMenuTitle?.text = leftText
    }
    func reloadBtn(btn:UILabel, item:ModelMenuItem)->() {
        if(item.isBeChosen){
            item.isBeChosen = false
        }
        else{
            item.isBeChosen = true
        }
        return

    }

}

