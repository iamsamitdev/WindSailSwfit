//
//  ProfileController.swift
//  WindSail
//
//  Created by Samit Koyom on 5/9/2562 BE.
//  Copyright © 2562 Samit Koyom. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProfileController: UIViewController {

    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var imgprofile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // แสดงชื่อจาก UserDefault
        let getFullname = UserDefaults.standard.value(forKey: "FULLNAME")
        fullname.text = getFullname as? String
        
        // แสดงรูปโปรไฟล์
        let getImgProfile = UserDefaults.standard.value(forKey: "IMGPROFILE") as? String
        
        let imgURL = NSURL(string:"https://www.itgenius.co.th/sandbox_api/ministockapi/public/images/profile/\(getImgProfile ?? "")")!
        imgprofile.af_setImage(withURL: imgURL as URL)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnLogout(_ sender: Any) {
        
        // Clear ข้อมูล UserDefault เป็น false
        UserDefaults.standard.set(false, forKey: "USERLOGGEDIN")
        // ส่งกลับไปหน้า Login
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    

}
