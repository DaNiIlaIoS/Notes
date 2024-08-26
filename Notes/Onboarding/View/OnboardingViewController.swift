//
//  Onboarding.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 22.08.2024.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    
}

final class OnboardingViewController: UIViewController, OnboardingViewProtocol {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.reuseId)
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private var presenter: OnboardingPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = OnboardingPresenter(view: self)
        view.addSubview(collectionView)
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.reuseId, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        cell.configCell(item: presenter.onboardingData[indexPath.item])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    
}

#Preview {
    OnboardingViewController()
}
