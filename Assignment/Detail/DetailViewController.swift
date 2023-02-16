//
//  DetailViewController.swift
//  Assignment
//
//  Created by 소하 on 2023/02/17.
//

import UIKit
import Kingfisher

class DetailViewController:UIViewController {
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var imgTv: UIImageView!
    @IBOutlet weak var labelHospital: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelComment: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    var type:ContentType = .TV
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SystemManager.shared.openLoading(vc: self)
        setUI(isTv: type == .TV ? true : false)
    }
    
    private func initUI() {
        imgTv.isHidden = true
        imgTv.kf.indicatorType = .activity
        imgEvent.isHidden = true
        imgEvent.kf.indicatorType = .activity
        btnClose.tintColor = .black
    }
    
    private func setUI(isTv:Bool) {
        imgTv.isHidden = !isTv
        imgEvent.isHidden = isTv
        labelHospital.font = .systemFont(ofSize: 12, weight: .bold)
        labelHospital.textColor = .black
        labelTitle.font = .systemFont(ofSize: 12, weight: .regular)
        labelTitle.textColor = .black
        labelComment.font = .systemFont(ofSize: 12, weight: .regular)
        labelComment.textColor = .lightGray
        labelComment.numberOfLines = 2
        SystemManager.shared.closeLoading()
    }
    
    func setData<T>(data:T, type:ContentType) {
        self.type = type
        switch type {
        case .TV:
            guard let curData = data as? YSTv else { return }
            guard let url = URL(string: curData.tvFullImgUrl) else { return }
            labelHospital.text = ""
            labelTitle.text = curData.tvNameMain
            labelComment.text = ""
            labelPrice.text = ""
            imgTv.kf.setImage(
                with: url,
                placeholder: nil,
                options: nil,
                completionHandler: { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        self.imgTv.image = UIImage(named: "defaultImgL")
                    }
                })
        case .RECOMMENDEVENT:
            guard let curData = data as? RecommendEvent else { return }
            guard let url = URL(string: curData.thumbnailImageUrl) else { return }
            labelHospital.text = curData.displayName
            labelTitle.text = curData.name
            labelComment.text = curData.comment
            setPrice(price: curData.price)
            print(url)
            imgEvent.kf.setImage(
                with: url,
                placeholder: nil,
                options: nil,
                completionHandler: { result in
                    
                print("??????")
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        self.imgEvent.image = UIImage(named: "defaultImg")
                    }
                })
        case .NEWEVENT:
            guard let curData = data as? NewEvent else { return }
            guard let url = URL(string: curData.thumbnailImageUrl) else { return }
            labelHospital.text = curData.displayName
            labelTitle.text = curData.name
            labelComment.text = curData.comment
            setPrice(price: curData.price)
            imgEvent.kf.setImage(
                with: url,
                placeholder: nil,
                options: nil,
                completionHandler: { result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        self.imgEvent.image = UIImage(named: "defaultImg")
                    }
                })
        }
    }
    // price
    private func setPrice(price:Int) {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        guard let strPrice = numberFormat.string(from: NSNumber(value: price)) else { return }
        let strUnit = "원"
        let strAll = strPrice + strUnit
        let attributeString = NSMutableAttributedString(string: strAll)
        let allRange = (strAll as NSString).range(of: strAll)
        let priceRange = (strAll as NSString).range(of: strPrice)
        let unitRange = (strAll as NSString).range(of: strUnit)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: allRange)
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: priceRange)
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .semibold), range: unitRange)
        labelPrice.attributedText = attributeString
    }
}

//MARK: - Event
extension DetailViewController {
    @IBAction func clickClose(_ sender:Any) {
        self.dismiss(animated: true)
    }
}
