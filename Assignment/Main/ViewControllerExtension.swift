//
//  ViewControllerExtension.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import UIKit

//MARK: - TableView
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    // 섹션 헤더
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = String(describing: SectionHeaderView.self)
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        guard let sectionHeaderView = nibs?.first as? SectionHeaderView else {
            return UIView()
        }
        sectionHeaderView.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                                         size: CGSize(width: tableView.frame.width, height: 60))
        switch section {
        case 0:
            sectionHeaderView.setUI(titleFirst: "추천", titleLast: "이벤트")
        case 1:
            sectionHeaderView.setUI(titleFirst: "신규", titleLast: "이벤트")
        default:
            return UIView()
        }
        return sectionHeaderView
    }
    // 섹션 푸터
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        let footerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                              size: CGSize(width: tableView.frame.width, height: 45)))
        footerView.backgroundColor = .white
        return footerView
    }
    // 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // 섹션 별 리스트
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return controller.getRecommendCount()
        case 1:
            return controller.getNewEventCount()
        default:
            return 0
        }
    }
    // cell 세팅
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
                return UITableViewCell()
            }
            let data = controller.getRecommend(index: indexPath.row)
            if let url = URL(string: data.thumbnailImageUrl) {
                cell.putData(display: data.displayName,
                             name: data.name,
                             comment: data.comment,
                             url: url,
                             price: data.price,
                             wish: data.wishCount,
                             review: data.reviewCount,
                             rate: data.rateScore)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell else {
                return UITableViewCell()
            }
            let data = controller.getNewEvent(index: indexPath.row)
            if let url = URL(string: data.thumbnailImageUrl) {
                cell.putData(display: data.displayName,
                             name: data.name,
                             comment: data.comment,
                             url: url,
                             price: data.price,
                             wish: data.wishCount,
                             review: data.reviewCount,
                             rate: data.rateScore)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    // 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    // 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = SystemManager.shared.getDetailVC() as? DetailViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .coverVertical
        present(nextVC, animated: true) { [self] in
            switch indexPath.section {
            case 0:
                nextVC.setData(data: controller.getRecommend(index: indexPath.row), type: .RECOMMENDEVENT)
            case 1:
                nextVC.setData(data: controller.getNewEvent(index: indexPath.row), type: .NEWEVENT)
            default:
                break
            }
        }
    }
}

//MARK: - CollectionView
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 리스트 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller.getTvCount()
    }
    // cell 세팅
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVCell", for: indexPath) as? TVCell else {
            return UICollectionViewCell()
        }
        let data = controller.getTv(index: indexPath.row)
        if let url = URL(string: data.tvFullImgUrl) {
            cell.putData(title: data.tvNameMain, url: url)
        }
        return cell
    }
    // 셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height
        return CGSize(width: cellHeight * 1.5, height: cellHeight)
    }
    // 좌우 padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
    // 셀 사이 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    // 셀 선택 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextVC = SystemManager.shared.getDetailVC() as? DetailViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.modalTransitionStyle = .coverVertical
        present(nextVC, animated: true) { [self] in
            nextVC.setData(data: controller.getTv(index: indexPath.row), type: .TV)
        }
    }
}
