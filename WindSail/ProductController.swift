//
//  ProductController.swift
//  WindSail
//
//  Created by Samit Koyom on 6/9/2562 BE.
//  Copyright © 2562 Samit Koyom. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ProductController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var productTable: UITableView!
    
    // Call Model to this
    var productData: [ProductModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "cellProductList", for: indexPath) as! ProductTableViewCell
        cell.productName.text = self.productData[indexPath.row].product_name
        cell.productBarcode.text = self.productData[indexPath.row].product_barcode
        cell.productPrice.text = self.productData[indexPath.row].product_price
   
        let getImageProduct = self.productData[indexPath.row].product_image
        if let imgURL = NSURL(string:"https://www.itgenius.co.th/sandbox_api/ministockapi/public/images/stock/\(getImageProduct)"){
            cell.imgProfile?.af_setImage(withURL: imgURL as URL)
        }

        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Height of table row
        self.productTable.rowHeight = 305
        
        // Load tableView
        self.productTable.delegate = self
        self.productTable.dataSource = self
        
        // Load Product from API
        let urlAPI = "https://www.itgenius.co.th/sandbox_api/ministockapi/public/api/products"
        Alamofire.request(urlAPI).responseJSON{
            (response) in
            switch response.result{
            case .success(let value):
                
                let json = JSON(value)
                //let data = json["data"]
                // print(json)
                json.array?.forEach({ (product) in
                    
                    let product = ProductModel(
                        id: product["id"].intValue,
                        product_name: product["product_name"].stringValue,
                        product_barcode: product["product_barcode"].stringValue,
                        product_price: product["product_price"].stringValue,
                        product_image: product["product_image"].stringValue)
                    self.productData.append(product)
                    
                    // การเพิ่มข้อมูลลงตาราง
                    self.productTable.reloadData()
                })
                
                break
            case .failure:
                print("Error to load data from API")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
