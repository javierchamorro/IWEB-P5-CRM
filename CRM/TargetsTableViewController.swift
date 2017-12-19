//
//  TargetsTableViewController.swift
//  CRM
//
//  Created by Oscar Sanchez Rueda on 22/11/2017.
//  Copyright © 2017 Oscar Sanchez Rueda. All rights reserved.
//

import UIKit



class TargetTableViewCell : UITableViewCell{
    
    
    
    @IBOutlet weak var companyLabel: UILabel!
    
    
    @IBOutlet weak var objectivesLabel: UILabel!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
}


class TargetsTableViewController: UITableViewController {
    
    
    
    
    var visits = [[String:Any]]()
    var index : IndexPath!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Targets"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let visit = visits[index.row]
        
        if let target = visit["Targets"] as? [[String:Any]]{
            
            let numero = target.count
            if numero == 0 {return 1}
            return numero
        
        }
        
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Target Cell", for: indexPath) as! TargetTableViewCell

        // Configure the cell...
        
        
        cell.companyLabel?.text = "No hay datos de la empresa"
        cell.objectivesLabel?.text = "No hay datos de los objetivos"
        cell.thirdLabel?.text = "Estado: pendiente"
        cell.thirdLabel?.backgroundColor = UIColor.yellow
        
        
        
        
        let visit = visits[index.row]
        
        if let target = visit["Targets"] as? [[String:Any]]{
            
            if !target.isEmpty {
                
                if let company = target[indexPath.row]["Company"] as? [String:Any]{
                    
                
            if let name = company["name"] as? String{
                
               if name != ""{
             cell.companyLabel?.text = "Empresa : " + name
                
                }
        
                }
            }
        
            }
        }
        
            
        if let target = visit["Targets"] as? [[String:Any]]{
                
            if !target.isEmpty {
                    
                    if let objective = target[indexPath.row]["TargetType"] as? [String:Any]{
                        
                        
                        if let name = objective["name"] as? String{
                            
                            if name != ""{
                            cell.objectivesLabel?.text = "Proposito : " + name
                            
                            }
                            
                        }
                    }
                    
                }
        }
        
        
        
        
        if let target = visit["Targets"] as? [[String:Any]]{
            
            if target.count != 0 {
                
                if let success = target[indexPath.row]["success"] as? Bool {
                    
                    if success == true {
                        cell.thirdLabel?.text = "Estado: cumplido"
                        cell.thirdLabel?.backgroundColor = UIColor.green
                    }
                    else{
                        cell.thirdLabel?.text = "Estado: fallido"
                        cell.thirdLabel?.backgroundColor = UIColor.red
                    }
                    
                }
            }
                    
        }
                   
               
    
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
