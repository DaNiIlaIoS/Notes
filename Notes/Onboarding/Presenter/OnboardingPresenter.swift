//
//  OnboardingPresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 22.08.2024.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    var onboardingData: [OnboardingModel] { get }
    var fromValue: CGFloat { get set }
    
    func getCurrentIndex(currentSlide: Int) -> CGFloat
    func updateFromValue(currentSlide: Int)
    func goToApp()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    let onboardingData: [OnboardingModel] = OnboardingModel.mockData()
    var currentPageIndex: CGFloat = 1
    var fromValue: CGFloat = 0
    
    weak var view: OnboardingViewProtocol?
    
    init(view: OnboardingViewProtocol) {
        self.view = view
        
    }
    
    func getCurrentIndex(currentSlide: Int) -> CGFloat {
        return (currentPageIndex / CGFloat(onboardingData.count)) * CGFloat(currentSlide + 1)
    }
    
    func updateFromValue(currentSlide: Int) {
        fromValue = getCurrentIndex(currentSlide: currentSlide)
    }
    
    func goToApp() {
        UserDefaults.standard.set(true, forKey: "goToApp")
        NotificationCenter.default.post(Notification(name: Notification.Name(.setSignInController)))
    }
}
