//
//  ViewController.swift
//  RM30308
//
//  Created by Danielle Pereira on 02/12/17.
//  Copyright © 2017 Danielle Pereira. All rights reserved.
//

import UIKit
import KingFisher

class ViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var lbAdv: UILabel!
    @IBOutlet weak var lbIbu: UILabel!
    @IBOutlet weak var ivBeer: UIImageView!
    
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if beer != nil {
            lbName.text = beer.name
            lbTagline.text = beer.tagline
            tvDescription.text = beer.description
            lbAdv.text = "\(beer.abv)"
            lbIbu.text = "\(beer.ibu)"
            
            
            let url = URL(string: beer.image_url)
            let resource = ImageResource(downloadUrl: url, cacheKey: beer.id)
            
            cell.ivBeer.kf.setImage(with: resource)
            
            /*
            var url_img: String?
            url_img = beer.image_url
            
            if url_img != nil {
                //ivBeer.kf.setImage(with: URL(string: url_img!))
            } else {
                print("Erro ao obter url!")
            }
            */
 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

