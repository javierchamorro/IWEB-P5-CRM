//
//  VisitTableTableViewController.swift
//  CRM
//
//  Created by Oscar Sanchez Rueda on 21/11/2017.
//  Copyright © 2017 Oscar Sanchez Rueda. All rights reserved.
//

import UIKit

typealias Visit = [String:Any]


class VisitTableViewCell : UITableViewCell{
    
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var sellLabel: UILabel!
    
    @IBOutlet weak var i: UIImageView!

    
    
}

class VisitTableTableViewController: UITableViewController {
    
    
    let TOKEN = "aafd788933dd74e98caa"
    
    var visits = [Visit]()
    
    var imgCache = [String: UIImage]()
    
   
    
    var direccion : String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
      
        downloadVisits()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visits.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Visit Cell", for: indexPath) as! VisitTableViewCell

        
        let visit = visits[indexPath.row]
        
        cell.nameLabel?.text = ""
        cell.dateLabel?.text=""
        cell.phoneLabel?.text=""
        
        
        if let customer = visit["Customer"] as? [String:Any],
            let name = customer["name"] as? String{
            cell.nameLabel?.text = "Cliente: "+name
        }

        
        if let plannedFor = visit["plannedFor"] as? String{
            
            // Convertir un String ISO8601 en una Date:
        
            
            let df = ISO8601DateFormatter()
            
            df.formatOptions = [.withFullDate]
            
            let d = df.date(from: plannedFor)
            
            cell.dateLabel?.text = "Fecha: "+df.string(from: d!)
        }
        
        
        if let customer = visit["Customer"] as? [String:Any],
            let phone = customer["phone1"] as? String{
            cell.phoneLabel?.text = "Tlf: "+phone
        }
        
        if let salesman = visit["Salesman"] as? [String:Any],
            let sellers = salesman["fullname"] as? String {
            
            cell.sellLabel?.text = "Vendedor: "+sellers
        }
        
        
        if let salesman = visit["Salesman"] as? [String:Any],
        let photo = salesman["Photo"] as? [String:Any],
            let strurl = photo["url"] as? String{
    
    
          if let img = imgCache[strurl]{
    
            cell.i?.image = img
    
          }   else {
            updatePhoto(strurl,for : indexPath)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "Select Target" {
            
            if let ttvc = segue.destination as? TargetsTableViewController{
                
                ttvc.visits = self.visits
                
                ttvc.index = tableView.indexPath(for: sender as! VisitTableViewCell)
            }
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    var session = URLSession.shared
    
    private func downloadVisits(){
        
      
        
        
        if let url = URL(string: direccion){
            
            
            
            let t = session.dataTask(with: url){ (data, response, error) in
                
                if error != nil {
                            
                   let msg : String? = "Atencion"
                   let msg2 : String? = "Ha ocurrido un error"
                            
                   let alert = UIAlertController(title: msg, message: msg2, preferredStyle: UIAlertControllerStyle.alert)
                            
                   let acc : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                            
                   alert.addAction(acc)
                            
                   self.present(alert, animated: true)
                
                    return
                }
                if (response as! HTTPURLResponse).statusCode != 200{
                    
                    let msg : String? = "Atencion"
                    let msg2 : String? = "No se ha podido descargar el JSON"
                    
                    let alert = UIAlertController(title: msg, message: msg2, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let acc : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                    
                    alert.addAction(acc)
                    
                    self.present(alert, animated: true)
                    
                    return
                }
                
                if let visits = (try? JSONSerialization.jsonObject(with: data!)) as? [Visit]{
                    
                    DispatchQueue.main.async {
                        self.visits = visits
                        self.tableView.reloadData()
                    }
                }
            
            
            }
             t.resume()
        }
    
    
    }
    
    
    
    private func updatePhoto(_ str : String, for indexpath: IndexPath) {
        
        
        DispatchQueue.global().async {
            
            if let url = URL(string: str),
               let data = try? Data(contentsOf: url),
                let img = UIImage(data: data){
                
                DispatchQueue.main.async {
                    
                    self.imgCache[str] = img
                    self.tableView.reloadRows(at: [indexpath], with: .left)
                    (self.tableView.cellForRow(at: indexpath) as! VisitTableViewCell).i?.image = img
                    
                    
                }
                
            }
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    

}
