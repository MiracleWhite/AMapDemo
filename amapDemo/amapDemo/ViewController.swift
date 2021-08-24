//
//  ViewController.swift
//  amapDemo
//
//  Created by Miracle on 2021/8/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        let btn: UIButton = {
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            btn.center = view.center
            btn.setTitle("跳转", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.addTarget(self, action: #selector(jump), for: .touchUpInside)
            return btn
        }()
        
        view.addSubview(btn)
        
        
    }
    
    @objc func jump() {
        
        let vc = example()
        navigationController?.pushViewController(vc, animated: true)
        
    }


}

