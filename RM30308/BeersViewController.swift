//
//  BeersViewController.swift
//  RM30308
//
//  Created by Danielle Pereira on 02/12/17.
//  Copyright © 2017 Danielle Pereira. All rights reserved.
//

import UIKit
import Kingfisher

class BeersViewController: UITableViewController {

    var beers: [Beer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBeers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.beer = beers[tableView.indexPathForSelectedRow!.row]
    }
    
    func loadBeers() {
        Rest.loadBeers { (beers: [Beer]?) in
            if let beers = beers {
                self.beers = beers
                
                //nao posso modificar elementos de UI em threads que nao seja main thread
                //por isso tenho que colocar oq quero q seja executado na mainthread dentro do Dispatch
                
                //o async executa
                DispatchQueue.main.async {
                    //o codigo que eu quero que seja executado na main thread
                    self.tableView.reloadData() // pq senao vai carregar vazia
                }
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let beer = beers[indexPath.row]
        
        //cell.imageView = ivBeer.kf.setImage(with: URL(string: beer.image_url))
        let resource = ImageResource(downloadUrl: URL(string: beer.image_url), cacheKey: beer.id)
        
        cell.ivBeer.kf.setImage(with: resource)
        cell.textLabel?.text = beer.name
        cell.detailTextLabel?.text = "Teor alcoólico: \(beer.abv)"
        
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
