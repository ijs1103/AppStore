//
//  FeatureSectionView.swift
//  AppStore
//
//  Created by Eunyeong Kim on 2021/08/10.
//

import SnapKit
import UIKit

final class FeatureSectionView: UIView {
    private var featureList: [Feature] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        // 스크롤 넘길때 하나의 아이템이 화면에 가득차게 넘겨짐, False일 때는 자연스럽게 넘겨짐
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            FeatureSectionCollectionViewCell.self,
            forCellWithReuseIdentifier: "FeatureSectionCollectionViewCell"
        )

        return collectionView
    }()

    private let separatorView = SeparatorView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

        fetchData()
        collectionView.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeatureSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        featureList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureSectionCollectionViewCell", for: indexPath) as? FeatureSectionCollectionViewCell
        let feature = featureList[indexPath.item]
        cell?.setup(feature: feature)

        return cell ?? UICollectionViewCell()
    }
}

extension FeatureSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: frame.width)
    }
    // 중앙정렬을 위한 코드 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    // vertical 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
}

private extension FeatureSectionView {
    func setupViews() {
        [
            collectionView,
            separatorView
        ].forEach { addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(snp.width)
            $0.bottom.equalToSuperview()
        }

        separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview()
        }
    }

    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else { return }

        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            featureList = result
        } catch {}
    }

}
