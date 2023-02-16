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
    @IBOutlet weak var labelWish: UILabel!
    @IBOutlet weak var labelReview: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SystemManager.shared.openLoading(vc: self)
    }
    // UI 초기화
    private func initUI() {
        labelHospital.text = ""
        labelTitle.text = ""
        labelComment.text = ""
        labelPrice.text = ""
        labelWish.text = ""
        labelReview.text = ""
        labelRate.text = ""
        labelHospital.font = .systemFont(ofSize: 12, weight: .bold)
        labelHospital.textColor = .black
        labelTitle.font = .systemFont(ofSize: 15, weight: .regular)
        labelTitle.textColor = .black
        labelTitle.numberOfLines = 2
        labelComment.font = .systemFont(ofSize: 12, weight: .regular)
        labelComment.textColor = .lightGray
        labelComment.numberOfLines = 2
        imgTv.kf.indicatorType = .activity
        imgEvent.kf.indicatorType = .activity
        btnClose.tintColor = .black
    }
    // ContentType에 따른 UI세팅
    private func setUI(isTv:Bool) {
        imgTv.isHidden = !isTv
        imgEvent.isHidden = isTv
        SystemManager.shared.closeLoading()
    }
    /// 상세페이지 데이터 세팅
    func setData<T>(data:T, type:ContentType) {
        setUI(isTv: type == .TV ? true : false)
        switch type {
        case .TV:
            guard let curData = data as? YSTv else { return }
            guard let url = URL(string: curData.tvFullImgUrl) else { return }
            labelHospital.text = "여신TV"
            labelTitle.text = curData.tvNameMain
            let numberFormat = NumberFormatter()
            numberFormat.numberStyle = .decimal
            guard let strCnt = numberFormat.string(from: NSNumber(value: Int(curData.tvViewCount) ?? 0)) else { return }
            labelComment.text = strCnt + "view"
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
            setWish(wish: curData.wishCount)
            setReview(review: curData.reviewCount)
            if curData.rateScore > 0 {
                let newRate = Float(curData.rateScore / curData.rateScore) * 2
                setRate(rate: newRate)
            } else {
                setRate(rate: 0.0)
            }
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
        case .NEWEVENT:
            guard let curData = data as? NewEvent else { return }
            guard let url = URL(string: curData.thumbnailImageUrl) else { return }
            labelHospital.text = curData.displayName
            labelTitle.text = curData.name
            labelComment.text = curData.comment
            setPrice(price: curData.price)
            setWish(wish: curData.wishCount)
            setReview(review: curData.reviewCount)
            if curData.rateScore > 0 {
                let newRate = Float(curData.rateScore / curData.rateScore) * 2
                setRate(rate: newRate)
            } else {
                setRate(rate: 0.0)
            }
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
    // wish
    private func setWish(wish:Int) {
        let strUnit = "관심도"
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        guard let strCnt = numberFormat.string(from: NSNumber(value: wish)) else { return }
        let strAll = strUnit + strCnt
        let attributeString = NSMutableAttributedString(string: strAll)
        let allRange = (strAll as NSString).range(of: strAll)
        let unitRange = (strAll as NSString).range(of: strUnit)
        let countRange = (strAll as NSString).range(of: strCnt)
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: allRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: unitRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.defaultPink, range: countRange)
        labelWish.attributedText = attributeString
    }
    // review
    private func setReview(review:Int) {
        let strUnit = "리뷰"
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        guard let strCnt = numberFormat.string(from: NSNumber(value: review)) else { return }
        let strAll = strUnit + strCnt
        let attributeString = NSMutableAttributedString(string: strAll)
        let allRange = (strAll as NSString).range(of: strAll)
        let unitRange = (strAll as NSString).range(of: strUnit)
        let countRange = (strAll as NSString).range(of: strCnt)
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: allRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: unitRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.defaultPink, range: countRange)
        labelReview.attributedText = attributeString
    }
    // rate
    private func setRate(rate:Float) {
        let strUnit = "★"
        let strCnt = String(rate)
        let strAll = strUnit + strCnt
        let attributeString = NSMutableAttributedString(string: strAll)
        let allRange = (strAll as NSString).range(of: strAll)
        let unitRange = (strAll as NSString).range(of: strUnit)
        let countRange = (strAll as NSString).range(of: strCnt)
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: allRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.yellow, range: unitRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.defaultPink, range: countRange)
        labelRate.attributedText = attributeString
    }
}

//MARK: - Event
extension DetailViewController {
    @IBAction func clickClose(_ sender:Any) {
        self.dismiss(animated: true)
    }
}
