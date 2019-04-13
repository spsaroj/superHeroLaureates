//
//  superHeroTableViewController.swift
//  superHeroLaureates
//
//  Created by Paudel,Saroj on 4/13/19.
//  Copyright © 2019 Paudel,Saroj. All rights reserved.
//

import UIKit

class superHeroTableViewController: UITableViewController {

    let superHeroJSON = "https://www.dropbox.com/s/wpz5yu54yko6e9j/squad.json?dl=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
          NotificationCenter.default.addObserver(self, selector:#selector(superHeroNotification(notification:)),name: NSNotification.Name("notification"), object:nil)
    }
    @objc func superHeroNotification (notification: Notification){
//        let superHeroes = notification.object as! [SuperHero]
        print("The Super Hero JSON was accessed")
    }
    var superHeroes: [Members] = []
    @IBAction func reloadData(_ sender: Any) {
        fetchSuperHeroes()
         tableView.reloadData()
    }
    
    
    func fetchSuperHeroes(){
        let urlSession = URLSession.shared
        let url = URL(string: superHeroJSON)
        urlSession.dataTask(with: url!, completionHandler: displaySuperHeroesInTableView).resume()
    }
    
    func displaySuperHeroesInTableView(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        
        do {
            let decoder:JSONDecoder = JSONDecoder()
            superHeroes = try decoder.decode(SuperHero.self, from: data!).members
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
             NotificationCenter.default.post(name: NSNotification.Name("notification"), object: superHeroes)
        } catch {
            print(error)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return superHeroes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superHeroID", for: indexPath)

        let superHero = superHeroes[indexPath.row]
        cell.textLabel?.text = "\(superHero.name) (aka: \(superHero.secretIdentity))"
        cell.detailTextLabel?.text = "\(superHero.powers.joined(separator: ", "))"
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
