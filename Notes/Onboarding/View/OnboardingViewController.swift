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
//        collectionView.backgroundColor = .background
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.reuseId)
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var skipButton = CustomButton.createSmallButton(title: "Skip")
    private lazy var nextButton: UIView = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
        
        let nextImage = UIImageView()
        nextImage.image = UIImage(systemName: "chevron.right.circle.fill")
        nextImage.tintColor = .gray
        nextImage.contentMode = .scaleAspectFit
        nextImage.translatesAutoresizingMaskIntoConstraints = false
        
        nextImage.widthAnchor.constraint(equalToConstant: 45).isActive = true
        nextImage.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addGestureRecognizer(tapGesture)
        view.addSubview(nextImage)
        
        nextImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    private lazy var pagerStack = CustomStack.createHStack(spacing: 5, alignment: .center)
    
    private lazy var hStack = CustomStack.createHStack(spacing: 0, distribution: .equalSpacing, alignment: .center)
    
    private var presenter: OnboardingPresenterProtocol!
    private var pagers: [UIView] = []
    private var currentSlide: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = OnboardingPresenter(view: self)
    
        view.addSubview(collectionView)
        view.addSubview(hStack)

        skipButton.setTitleColor(.gray, for: .normal)
        createPageControl()
    }
    
    @objc func nextSlide() {
        let maxSlide = presenter.onboardingData.count - 1
        
        if currentSlide < maxSlide {
            currentSlide += 1
            collectionView.scrollToItem(at: IndexPath(item: currentSlide, section: 0), at: .centeredHorizontally, animated: true)
            updatePagersConstraints()
        }
    }
    
    @objc func scrollToSlide(sender: UIGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        print("Selected slide with tag:", index)
        
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        currentSlide = index
        updatePagersConstraints()
    }
    
    private func createPageControl() {
        hStack.addArrangedSubview(skipButton)
        hStack.addArrangedSubview(pagerStack)
        hStack.addArrangedSubview(nextButton)
        
        for page in 0..<presenter.onboardingData.count {
            let view = UIView()
            view.tag = page
            view.backgroundColor = .gray
            view.layer.cornerRadius = 5
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollToSlide(sender: ))))
            
            pagers.append(view)
            pagerStack.addArrangedSubview(view)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        
        updatePagersConstraints()
    }
    
    func updatePagersConstraints() {
        pagers.forEach { page in
            let tag = page.tag
            let viewTag = currentSlide
            
            page.constraints.forEach { constraint in
                page.removeConstraint(constraint)
            }
            
            if tag == viewTag {
                page.layer.opacity = 1
                page.widthAnchor.constraint(equalToConstant: 20).isActive = true
            } else {
                page.layer.opacity = 0.5
                page.widthAnchor.constraint(equalToConstant: 10).isActive = true
            }
            
            page.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.onboardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.reuseId, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        cell.configCell(item: presenter.onboardingData[indexPath.item])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegate {

}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let curentSlide = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.currentSlide = curentSlide
        updatePagersConstraints()
    }
}
