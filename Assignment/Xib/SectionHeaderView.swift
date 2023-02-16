//
//  SectionHeaderView.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import UIKit

class SectionHeaderView: UIView {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var line: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    /// 섹션 헤더 UI 세팅
    func setUI(titleFirst:String, titleLast:String) {
        line.backgroundColor = .black
        //
        let titleAll = titleFirst + titleLast
        let attributeString = NSMutableAttributedString(string: titleAll)
        let allRange = (titleAll as NSString).range(of: titleAll)
        let firstRange = (titleAll as NSString).range(of: titleFirst)
        let lastRange = (titleAll as NSString).range(of: titleLast)
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .semibold), range: allRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: firstRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.defaultPink, range: lastRange)
        labelTitle.attributedText = attributeString
    }
}
