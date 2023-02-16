//
//  EventCell.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import UIKit
import Kingfisher

class EventCell: UITableViewCell {
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var btnReservation: UIButton!
    @IBOutlet weak var scriptView: UIView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDisplay: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelComment: UILabel!
    @IBOutlet weak var labelWish: UILabel!
    @IBOutlet weak var labelReview: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            self.backgroundColor = .lightGray.withAlphaComponent(0.1)
        } else {
            self.backgroundColor = .white
        }
    }
    
    // UI 세팅
    private func initUI() {
        self.selectionStyle = .none
        self.separatorInset = .zero
        //
        scriptView.backgroundColor = .clear
        imgThumbnail.layer.cornerRadius = 10
        imgThumbnail.kf.indicatorType = .activity
        btnReservation.backgroundColor = .defaultPink
        btnReservation.layer.cornerRadius = 10
        btnReservation.titleLabel?.font = .systemFont(ofSize: 10, weight: .semibold)
        btnReservation.setTitleColor(.white, for: .normal)
        //
        labelDisplay.font = .systemFont(ofSize: 12, weight: .semibold)
        labelDisplay.textColor = .gray
        labelName.font = .systemFont(ofSize: 15, weight: .semibold)
        labelName.textColor = .black
        labelComment.font = .systemFont(ofSize: 12, weight: .semibold)
        labelComment.textColor = .lightGray
        labelComment.numberOfLines = 2
    }
    /// 이벤트 데이터 넣기
    func putData(display:String, name:String, comment:String, url:URL, price:Int, wish:Int, review:Int, rate:Int) {
        labelDisplay.text = display
        labelName.text = name
        labelComment.text = comment
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
                    self.imgThumbnail.image = UIImage(named: "defaultImg")
                }
            })
        //
        setPrice(price: price)
        setWish(wish: wish)
        setReview(review: review)
        if rate > 0 {
            let newRate = Float(rate / review) * 2
            setRate(rate: newRate)
        } else {
            setRate(rate: 0.0)
        }
    }
    // price
    private func setPrice(price:Int) {
        let strPrice = String(price / 10000)
        let strUnit = "만원"
        let strAll = strPrice + strUnit
        let attributeString = NSMutableAttributedString(string: strAll)
        let allRange = (strAll as NSString).range(of: strAll)
        let priceRange = (strAll as NSString).range(of: strPrice)
        let unitRange = (strAll as NSString).range(of: strUnit)
        attributeString.addAttribute(.foregroundColor, value: UIColor.defaultPink, range: allRange)
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: priceRange)
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .semibold), range: unitRange)
        labelPrice.attributedText = attributeString
    }
    // wish
    private func setWish(wish:Int) {
        let strUnit = "관심도"
        let strCnt = countingNum(total: wish)
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
        let strCnt = countingNum(total: review)
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
        attributeString.addAttribute(.foregroundColor, value: UIColor.lightGray, range: unitRange)
        attributeString.addAttribute(.foregroundColor, value: UIColor.defaultPink, range: countRange)
        labelRate.attributedText = attributeString
    }
    // 카운팅
    private func countingNum(total:Int) -> String {
        var result = total
        var count = 0.0
        var unit = ""
        
        while result > 0 {
            result /= 10
            count += 1
        }
        
        if count > 0 {
            let first = Int(total/Int(pow(10.0, count - 1)))
            unit += String(first)
        }
                
        switch count {
        case 0:
            return "0"
        case 1:
            unit = "1+"
        case 2:
            unit += "0+"
        case 3:
            unit += "백+"
        case 4:
            unit += "천+"
        case 5:
            unit += "만+"
        default:
            return "999"
        }
        return unit
    }
}
