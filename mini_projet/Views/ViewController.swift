//
//  ViewController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 16/11/2022.
//

import UIKit
import PDFKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var GetStarted: UIButton!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var SloganLabel: UILabel!
    
    
    @IBOutlet weak var WebViewPdf: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLabel.sizeToFit()
        TitleLabel.center.x = self.view.center.x
        
        SloganLabel.center.x = self.view.center.x
      
       
    }
    

    @IBAction func Terms(_ sender: Any) {
        let path = Bundle.main.path(forResource: "dummy", ofType: "pdf")
        let url = URL(fileURLWithPath: path!)
        let request = URLRequest(url:url)
        
        WebViewPdf.load(request)
    }
}

