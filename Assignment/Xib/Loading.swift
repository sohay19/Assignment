//
//  Loading.swift
//  Assignment
//
//  Created by 소하 on 2023/02/17.
//

import UIKit

class Loading:UIView {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 로딩 뷰 UI 세팅
    func setUI() {
        self.backgroundColor = .white.withAlphaComponent(0.5)
        indicator.startAnimating()
    }
}
