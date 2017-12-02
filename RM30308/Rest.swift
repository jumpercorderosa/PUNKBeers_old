//
//  Rest.swift
//  RM30308
//
//  Created by Danielle Pereira on 02/12/17.
//  Copyright © 2017 Danielle Pereira. All rights reserved.
//

import Foundation
import UIKit

class Rest {
    
    //caminho base da api
    static let basePath = "https://api.punkapi.com/v2/beers/"
    
    //mantem a configuracao de toda a sessao, que gerencia as requisicoes
    //instanciando ja passando algumas configuracoes
    static let configuration: URLSessionConfiguration = {
        
        let config = URLSessionConfiguration.default
        
        //o usuario consegue utilizar a api se ele estiver no 3g
        config.allowsCellularAccess = true
        
        //timeout da requisicao
        config.timeoutIntervalForRequest = 45.0
        
        //maximo de conexoes no host
        config.httpMaximumConnectionsPerHost = 5
        
        //eh util para setar um token pois fica padrao para todas as requisicoes
        // nao preciso ficar setando em todas as requisicoes
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        return config
    } ()
    
    //passo com o arquivo de configuracao para o objeto de sessao
    static let session = URLSession(configuration: configuration)
    
    //closure eh uma funcao anonima
    //func xxx(cars: [Car]?) -> Void {
    //}
    
    //pedir os carros cadastrados na minha api
    //escaping ==> valor fica retido na memoria pq esta sendo utilizado dentro do dataTask e esse metodo eh assincrono
    static func loadBeers(onComplete: @escaping ([Beer]?) -> Void) {
        
        //session data task
        guard let url = URL(string: basePath) else {
            onComplete(nil)
            return
        }
        
        //url q vc vai usar para consumir os dados
        session.dataTask(with: url) { (data: Data?, response:URLResponse?, error: Error?) in
            
            if error != nil {
                print("Erro ao acessar PUNK API v2!!!")
                onComplete(nil)
            } else {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    
                    //array de dictionary cuja chave eh uma string e o valor eh any
                    //as? [[String: Any]]
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]]
                        
                        var beers: [Beer] = []
                        for item in json {
                            
                            let image_url = item["image_url"] as! String
                            let name = item["name"] as! String
                            let tagline = item["tagline"] as! String
                            let abv = item["abv"] as! Double
                            let ibu = item["ibu"] as! Double
                            let description = item["description"] as! String
                            
                            //Uso pra fazer cache ou nao???
                            let id = item["id"] as! String

                            
                            let beer = Beer(_image_url: image_url, _name: name, _tagline: tagline, _abv: abv, _ibu: ibu, _description: description, _id: id)
                        
                            beers.append(beer)
                            
                            //chamei a api, peguei as cervejas, transformei em json, criei um array de car, varri o json, adicionei ao vetor
                            //e devolvo o vetor na closure
                            
                        }
                        
                        //devolvo a closure preenchida
                        onComplete(beers)
                        
                    } catch {
                        print(error.localizedDescription)
                        onComplete(nil)
                    }
                    
                } else {
                    print("Erro no servidor: ", response.statusCode)
                    onComplete(nil)
                }
            }
            
            //ja executa o metodo
            }.resume()
        
    }
    
    
    //a closure devolve a imagem q vai ser mostrada no ImageView
    static func downloadImage(url: String, onComplete: @escaping(UIImage?) -> Void) {
        
        guard let url = URL(string: url) else {
            onComplete(nil)
            return
        }
        
        session.downloadTask(with: url) { (imageURL: URL?, response: URLResponse?, error: Error?) in
            
            ///se eu conseguir desembrulhar o response, o image URL e o statusCode for igual a 200
            //imageUrl eh a url imagem q foi salva no seu device
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let imageURL =
                
                imageURL {
                
                //objeto bruto que representa a minha imagem
                let imageData = try! Data(contentsOf: imageURL)
                let image = UIImage(data: imageData)
                onComplete(image)
            } else {
                onComplete(nil)
            }
            
            }.resume()
    }
    
}



