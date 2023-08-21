//
//  CustomCell.swift
//  ToDOListFromTask
//
//  Created by User on 28.11.2020.
//

import UIKit

protocol CustomCellDelegate {
    func editCell(cell: CustomCell)
    func deleteCell(cell: CustomCell)
}

class CustomCell: UITableViewCell {
    
    var delegate: CustomCellDelegate?
    
    @IBOutlet weak var customCellTextLabel: UILabel!
    
    @IBOutlet weak var customCellEditButton: UIButton!
    
    @IBOutlet weak var customCellDeleteButton: UIButton!
    
    
    
    @IBAction func customCellEditButtonAction(_ sender: UIButton) {
            delegate?.editCell(cell: self)
    }
    
    
    @IBAction func customCellDeleteButtonAction(_ sender: UIButton) {
            delegate?.deleteCell(cell: self)
    }


}

