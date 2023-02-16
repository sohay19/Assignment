//
//  TVCell.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import UIKit
import Kingfisher

class TVCell: UICollectionViewCell {
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
      
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                labelTitle.textColor = .lightGray
            } else {
                labelTitle.textColor = .black
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    // UI 초기화
    private func initUI() {
        imgThumbnail.layer.cornerRadius = 10
        imgThumbnail.kf.indicatorType = .activity
        labelTitle.font = .systemFont(ofSize: 12, weight: .regular)
        labelTitle.textColor = .black
    }
    /// 여신TV 데이터 넣기
    func putData(title:String, url:URL) {
        labelTitle.text = title
        //
        imgThumbnail.kf.setImage(
            with: url,
            placeholder: nil,
            options: nil,
            completionHandler: { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self.imgThumbnail.image = UIImage(named: "defaultImgL")
                }
            })
    }
}
