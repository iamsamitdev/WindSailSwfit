//
//  ViewController.swift
//  WindSail
//
//  Created by Samit Koyom on 4/9/2562 BE.
//  Copyright © 2562 Samit Koyom. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // เช็คว่ามีการล็อกมาแล้วหรือยัง
        if UserDefaults.standard.bool(forKey: "USERLOGGEDIN") == true {
            // ส่งไปหน้า Dashboard
            let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "dashboardVC") as! DashboardController
            self.navigationController?.pushViewController(
                dashboardVC, animated: true)
        }
        
        // ทดสอบเรียกหน้า product API ด้วย Alamofire
        /*
        let urlAPI = "https://www.itgenius.co.th/sandbox_api/ministockapi/public/api/products"
        Alamofire.request(urlAPI).responseJSON{
            (response) -> Void in
            
            if let JSON = response.result.value{
                print(JSON)
            }
            
        }
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        // รับค่าจากฟอร์ม
        let getUsername = username.text!
        let getPassword = password.text!
        
        if getUsername.isEmpty || getPassword.isEmpty {
            print("Please enter username and password")
        }else{
            // Call API to check username and password
            let urlAPI = "https://www.itgenius.co.th/sandbox_api/ministockapi/public/api/user/login"
            let parameters = [
                "username": getUsername,
                "password": getPassword
            ]
            Alamofire.request(
                urlAPI,
                method:.post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: [:]).responseJSON{
                response in
                    let result = response.result.value as! NSDictionary
                    // print(result["status"] ?? "")
                    if result.value(forKey: "status") as! String == "success" {
                        // print("Loign success")
                        
                        // เก็บข้อมูลลงตัวแปร userDefault
                        UserDefaults.standard.set(true, forKey: "USERLOGGEDIN")
                        UserDefaults.standard.set(result["fullname"], forKey: "FULLNAME")
                        UserDefaults.standard.set(result["img_profile"], forKey: "IMGPROFILE")
                        
                        // ส่งไปหน้า Dashboard
                        let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "dashboardVC") as! DashboardController
                        self.navigationController?.pushViewController(
                            dashboardVC, animated: true)
                    }else{
                        // print("Loign fail")
                        // Alert Login Fail
                        let alert = UIAlertController(
                            title: "Status Login",
                            message: "Login Fail!",
                            preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(
                            title: "Yes",
                            style: .default,
                            handler: nil))
                        self.present(alert, animated: true)
                    }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

