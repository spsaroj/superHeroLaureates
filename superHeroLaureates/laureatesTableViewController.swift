//
//  laureatesTableViewController.swift
//  superHeroLaureates
//
//  Created by Paudel,Saroj on 4/13/19.
//  Copyright © 2019 Paudel,Saroj. All rights reserved.
//

import UIKit

class laureatesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:#selector(laureatesNotification(notification:)),name: NSNotification.Name("notification"), object:nil)
    }
    
    @objc func laureatesNotification (notification: Notification){
//        let laureates = notification.object as! [Laureates]
        print("The laureates JSON was accessed")
    }
    
    @IBAction func refreshPage(_ sender: Any) {
        fetchLaureates()
    }
    

    var laureatesJSON = "https://www.dropbox.com/s/7dhdrygnd4khgj2/laureates.json?dl=1"
    var laureates:[Laureates] = []
    // called to start the temperature fetching process
    func fetchLaureates(){
        
        let urlSession = URLSession.shared
        let url = URL(string: laureatesJSON)
        urlSession.dataTask(with: url!, completionHandler: displayLauratesTable).resume()
    }
    func displayLauratesTable(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        var laurateasFetched:[[String:Any]]
        var laurateasBlank:[String:Any]!
        
        do {
            // the JSON is an array of objects, so typecast as [[String:Any]]
            try laurateasFetched = JSONSerialization.jsonObject(with:data!, options: .allowFragments) as!
                [[String:Any]]
            // Each element of scottishDepartments is an object, so parse it as [String:Any]
            for i in 0 ..< laurateasFetched.count {
                laurateasBlank = laurateasFetched[i]
                
                // The department properties are Int, Int and String, so typecast appropriately:
                let firstName = laurateasBlank["firstname"] as? String
                let lastName = laurateasBlank["surname"] as? String
                let birth = laurateasBlank["born"] as? String
                let death = laurateasBlank["died"] as? String
                
                laureates.append(Laureates(firstname: firstName ?? "", surname: lastName ?? "", born: birth ?? "", died: death ?? ""))
            }
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
            // Now scotDepts can be sent to a TVC via a notification, printed, &c.
             NotificationCenter.default.post(name: NSNotification.Name("notification"), object: laureates)
//            for laurate in laureates{
//                print(laurate)
//            }
        }catch {
            print(error)
        }
    }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return laureates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "laureatesID", for: indexPath)

        let laureate = laureates[indexPath.row]
        cell.textLabel?.text = "\(laureate.firstname) \(laureate.surname))"
        cell.detailTextLabel?.text = "\(laureate.born) - \(laureate.died)"

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
