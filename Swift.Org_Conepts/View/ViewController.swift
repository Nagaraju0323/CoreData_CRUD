//
//  ViewController.swift
//  Swift.Org_Conepts
//
//  Created by Nagaraju on 14/11/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var userTbl:UITableView!
    @IBOutlet weak var addBtn:UIButton!
    
    var employees: [Manager] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UserInfo"
        userTbl.delegate = self
        userTbl.dataSource = self
        addBtn.clipsToBounds = true
        addBtn.layer.cornerRadius = addBtn.frame.size.width/2
        featchLocalData()
    }
    
    func featchLocalData() {
        employees.removeAll()
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Manager.self)
        result?.forEach { (cdEmployee) in
            employees.append(cdEmployee)
        }
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.userTbl.reloadData()
        }
    }
    
    
    @IBAction func addBtnCLK(_ sender:UIButton) {
        _ = UIAlertController(title: "Enter EmployeeDetails", message: nil, preferredStyle: .alert)
        presentInputAlert(
            title: "Enter User Details",
            textFields: [
                (placeholder: "Enter Id", keyboardType: .numberPad),
                (placeholder: "Enter EmpName", keyboardType: .default),
                (placeholder: "Enter Department", keyboardType: .default),
                (placeholder: "Enter Email", keyboardType: .emailAddress)
            ]
        ) { inputs in
            guard let empId = inputs[0],
                  let empName = inputs[1],
                  let department = inputs[2],
                  let empEmail = inputs[3] else { return }
            
            let newUser = Manager(context: PersistentStorage.shared.context)
            newUser.empId = Int64(empId) ?? 0
            newUser.empName = empName
            newUser.department = department
            newUser.empEmail = empEmail
            PersistentStorage.shared.saveContext()
            self.featchLocalData()
        }
    }
    
    func editProfileInfor(_ pathIndex:Int) {
        
        let employeeToEdit = employees[pathIndex]
        _ = UIAlertController(title: "UpDate EmpDetails", message: nil, preferredStyle: .alert)
        presentInputAlert(
            title: "Enter User Details",
            textFields: [
                (placeholder: "\(employeeToEdit.empId)", keyboardType: .numberPad),
                (placeholder: "\(employeeToEdit.empName ?? "") ", keyboardType: .default),
                (placeholder: "\(employeeToEdit.department ?? "")", keyboardType: .default),
                (placeholder: "\(employeeToEdit.empEmail ?? "")", keyboardType: .emailAddress)
            ]
        ) { inputs in
            guard let empId = inputs[0],
                  let empName = inputs[1],
                  let department = inputs[2],
                  let empEmail = inputs[3] else { return }
            employeeToEdit.empId = Int64(empId) ?? 0
            employeeToEdit.empName = empName
            employeeToEdit.department = department
            employeeToEdit.empEmail = empEmail
            PersistentStorage.shared.saveContext()
            self.featchLocalData()
        }
    }
    
}

extension UIViewController {
    func presentInputAlert(
        title: String,
        message: String? = nil,
        textFields: [(placeholder: String, keyboardType: UIKeyboardType)],
        onSubmit: @escaping ([String?]) -> Void
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for field in textFields {
            alertController.addTextField { textField in
                textField.placeholder = field.placeholder
                textField.keyboardType = field.keyboardType
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let inputs = alertController.textFields?.map { $0.text }
            onSubmit(inputs ?? [])
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomCell else { return UITableViewCell() }
        cell.EmpID.text = "EmpID : \(employees[indexPath.row].empId) "
        cell.empName.text = "empName : \(employees[indexPath.row].empName ?? "")  "
        cell.DepartmentLbl.text = "Department : \(employees[indexPath.row].department ?? "") "
        cell.empEmail.text = "empEmail : \(employees[indexPath.row].empEmail ?? "") "
        cell.selectionStyle = .none
        cell.isSelectd = {[weak self] isEditing in
            guard let self = self else { return }
            editProfileInfor(indexPath.row)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employeeToDelete = employees[indexPath.row]
            PersistentStorage.shared.context.delete(employeeToDelete)
            PersistentStorage.shared.saveContext()
            self.employees.remove(at: indexPath.row)
            self.userTbl.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}





