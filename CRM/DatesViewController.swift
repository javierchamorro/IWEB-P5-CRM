//
//  DatesViewController.swift
//  CRM
//
//  Created by Oscar Sanchez Rueda on 21/11/2017.
//  Copyright © 2017 Oscar Sanchez Rueda. All rights reserved.
//

import UIKit

class DatesViewController: UIViewController {

    @IBOutlet weak var fechaInicialDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var fechaFinalDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var selectButton: UIButton!
    
    
    let TOKEN = "aafd788933dd74e98caa"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "CRM"

        // Do any additional setup after loading the view.
        
        let datos = UserDefaults.standard
        if let datoFechaInicialDicc = datos.object(forKey: "fechaInicial") as? Date{
            
            fechaInicialDatePicker.date = datoFechaInicialDicc
        }
        else{
            fechaInicialDatePicker.date = Date()
        }
        if let datoFechaFinalDicc = datos.object(forKey: "fechaFinal") as? Date{
            
            fechaFinalDatePicker.date = datoFechaFinalDicc
        }
        else{
            fechaFinalDatePicker.date = Date()
        }
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        
        if identifier == "Fechas Seleccionadas"{
            
            if fechaInicialDatePicker.date > fechaFinalDatePicker.date  {
                
                let msg : String? = "Atencion"
                let msg2 : String? = "La fecha inicial debe ser anterior a la final"
                
                let alert = UIAlertController(title: msg, message: msg2, preferredStyle: UIAlertControllerStyle.alert)
                
                let acc : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                
                alert.addAction(acc)
                
                present(alert, animated: true)
                return false
            }
            
        
            
        }
        
        if identifier == "Favoritas"{
            
            if fechaInicialDatePicker.date > fechaFinalDatePicker.date  {
                
                let msg : String? = "Atencion"
                let msg2 : String? = "La fecha inicial debe ser anterior a la final"
                
                let alert = UIAlertController(title: msg, message: msg2, preferredStyle: UIAlertControllerStyle.alert)
                
                let acc : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                
                alert.addAction(acc)
                
                present(alert, animated: true)
                return false
            }
            
            
        }
        
        if identifier == "User Visits"{
            
            if fechaInicialDatePicker.date > fechaFinalDatePicker.date  {
                
                let msg : String? = "Atencion"
                let msg2 : String? = "La fecha inicial debe ser anterior a la final"
                
                let alert = UIAlertController(title: msg, message: msg2, preferredStyle: UIAlertControllerStyle.alert)
                
                let acc : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                
                alert.addAction(acc)
                
                present(alert, animated: true)
                return false
            }
            
        }
        
        return true
        
    }
    

  

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
        if segue.identifier == "Fechas Seleccionadas" {
            
            let datos = UserDefaults.standard
            
            datos.set(fechaFinalDatePicker.date, forKey: "fechaFinal")
            datos.set(fechaInicialDatePicker.date, forKey: "fechaInicial")
            datos.synchronize()
            
            
            
            
            if let vtvc = segue.destination as? VisitTableTableViewController {
                
                
                let df = ISO8601DateFormatter()
                
                df.formatOptions = [.withFullDate]
                
                
                   vtvc.title = "Todas las visitas"
                vtvc.direccion = "https://dcrmt.herokuapp.com/api/visits/flattened?token=\(self.TOKEN)&dateafter=\(df.string(from: fechaInicialDatePicker.date))&datebefore=\(df.string(from: fechaFinalDatePicker.date))"
                
                
                
            }
        }
        
        
        if segue.identifier == "Favoritas" {
            
            
            let datos = UserDefaults.standard
            
            datos.set(fechaFinalDatePicker.date, forKey: "fechaFinal")
            datos.set(fechaInicialDatePicker.date, forKey: "fechaInicial")
            datos.synchronize()
            
            
            
            
            if let vtvc = segue.destination as? VisitTableTableViewController {
                
                
                let df = ISO8601DateFormatter()
                
                df.formatOptions = [.withFullDate]
                
                vtvc.title = "Favoritas"
                
                vtvc.direccion = "https://dcrmt.herokuapp.com/api/visits/flattened?token=\(self.TOKEN)&dateafter=\(df.string(from: fechaInicialDatePicker.date))&datebefore=\(df.string(from: fechaFinalDatePicker.date))&favourites=1"
            }
            
            
            
            
        }
        
        
        if segue.identifier == "User Visits" {
            
            
            let datos = UserDefaults.standard
            
            datos.set(fechaFinalDatePicker.date, forKey: "fechaFinal")
            datos.set(fechaInicialDatePicker.date, forKey: "fechaInicial")
            datos.synchronize()
            
            
            
            
            if let vtvc = segue.destination as? VisitTableTableViewController {
                
                
                let df = ISO8601DateFormatter()
                
                df.formatOptions = [.withFullDate] //, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
    
                
                   vtvc.title = "Nuestras visitas (Javier y Oscar)"                
                
                vtvc.direccion = "https://dcrmt.herokuapp.com/api/users/tokenOwner/visits/flattened?token=\(self.TOKEN)&dateafter=\(df.string(from: fechaInicialDatePicker.date))&datebefore=\(df.string(from: fechaFinalDatePicker.date))"
            }
            
            
            
            
        }
        
        
        
        
    }
    

}
