//
//  OnboardingPresenter.swift
//  Notes
//
//  Created by Даниил Сивожелезов on 22.08.2024.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    var onboardingData: [OnboardingModel] { get }
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    
    weak var view: OnboardingViewProtocol?
    
    init(view: OnboardingViewProtocol) {
        self.view = view
    }
    
    let onboardingData: [OnboardingModel] = [OnboardingModel(title: "Registration", text: "Registration is required to gain access to all the features of our application. Registration is very simple - it only takes a few minutes!", animationName: "a1"),
                                             OnboardingModel(title: "Login", text: "To continue using our service, you need to log in. If you already have an account, simply log in. If not, create one in a couple of minutes!", animationName: "a2"),
                                             OnboardingModel(title: "Use App", text: "Thank you for choosing our application! We wish you a great experience and a pleasant time with our application!", animationName: "a3")]
}
