//
//  CustomCell.swift
//  Swift.Org_Conepts
//
//  Created by Nagaraju on 17/11/24.
//

import Foundation
import UIKit

class CustomCell : UITableViewCell {
    @IBOutlet weak var EmpID:UILabel!
    @IBOutlet weak var empName:UILabel!
    @IBOutlet weak var DepartmentLbl:UILabel!
    @IBOutlet weak var  empEmail:UILabel!
    @IBOutlet weak var editBtn:UIButton!
    var isEditingClk: Bool = false
    var isSelectd:((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editBtn.addTarget(self, action: #selector(editButnCLK), for: .touchUpInside)
    }
    
    @objc func editButnCLK() {
        isSelectd?(true)
    }
}
