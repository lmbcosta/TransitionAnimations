//
//  TransitionAnimator.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 08/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import Foundation
import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // Properties
    private let transitionDuration: TimeInterval = 0.6
    private let shrinkDuration: TimeInterval = 0.2
    
    var cardModel: Model.Card?
    var transition: Transition = .present
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Container View
        let containerView = transitionContext.containerView
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        // View Controllers
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        // Get selected Card View
        guard let cardView = getCardView(from: fromVC, to: toVC) else { return }
        
        cardView.isHidden = true
        
        // Create a card View clone
        guard let cardViewClone = makeCardViewClone(cardView: cardView) else { return }
        
        // Get the absolute rect for your cardViewCopy to set the frame
        let convertedFrame = cardView.convert(cardView.frame, to: nil)
        cardViewClone.frame = convertedFrame
        
        // Add card view clone to containerView
        containerView.addSubview(cardViewClone)
        
        if transition == .present {
            guard let detailVC = toVC as? DetailViewController else { return }
            containerView.addSubview(detailVC.view)
            containerView.sendSubviewToBack(detailVC.view)
            
            detailVC.shouldHideViews = true
            
            applyAnimations(to: cardViewClone, containerView: containerView, yOrigin: 0, damping: 0.75, springVelocity: 4, then: {
                cardView.isHidden = false
                
                cardViewClone.removeFromSuperview()
                transitionContext.completeTransition(true)
                detailVC.shouldHideViews = false
            })
        }
        else {
            if let detailVC = fromVC as? DetailViewController,
                  let cardViewFrame = detailVC.getCardViewFrame() {
                cardViewClone.frame = cardViewFrame
            }
            
            applyAnimations(to: cardViewClone, containerView: containerView, yOrigin: convertedFrame.origin.y, damping: 0.6, springVelocity: 2, then: {
                cardView.isHidden = false
                transitionContext.completeTransition(true)
            })
        }
    }
}

private extension TransitionAnimator {
    func getCardView(from: UIViewController?, to: UIViewController?) -> CardView? {
        guard let cardView = transition == .present ? (from as! ListViewController).getSelectedCardView() : (to as! ListViewController).getSelectedCardView() else { return nil }
        
        return cardView
    }
    
    func makeCardViewClone(cardView: CardView) -> CardView? {
        guard let model = cardModel else { return nil }
        
        let clone = CardView()
        clone.setCard(title: model.title, subtitle: model.subtitle, image: model.image, color: model.color, mode: transition.cardMode)
        
        return clone
    }
    
    func applyAnimations(to cardView: CardView,
                         containerView: UIView,
                         yOrigin: CGFloat,
                         damping: CGFloat,
                         springVelocity: CGFloat,
                         then handler: @escaping () -> Void) {
        
        if transition == .present {
            // Contract
            UIView.animate(withDuration: shrinkDuration, animations: {
                cardView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }, completion: { _ in
                cardView.layoutIfNeeded()
                cardView.updateLayout(for: self.transition.next.cardMode)
                self.increaseDecrease(cardView: cardView, yOrigin: yOrigin, containerView: containerView, duration: self.transitionDuration - self.shrinkDuration, damping: damping, initialSpringVelocity: springVelocity, then: handler)
            })
        }
        else {
            cardView.layoutIfNeeded()
            cardView.updateLayout(for: self.transition.next.cardMode)
            self.increaseDecrease(cardView: cardView, yOrigin: yOrigin, containerView: containerView, duration: self.transitionDuration, damping: 0.6, initialSpringVelocity: 0.4, then: handler)
        }
    }
    
    func increaseDecrease(cardView: CardView,
                          yOrigin: CGFloat,
                          containerView: UIView,
                          duration: TimeInterval,
                          damping: CGFloat,
                          initialSpringVelocity: CGFloat,
                          then handler: @escaping () -> Void) {
        
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: initialSpringVelocity, options: [], animations: {
            cardView.transform = .identity
            cardView.frame.origin.y = yOrigin
            cardView.updateCornerRadius(for: self.transition.next.cardMode)
            containerView.layoutIfNeeded()
        }, completion: { _ in handler() })
    }
}

extension TransitionAnimator {
    enum Transition {
        case present
        case dismiss
        
        var cardMode: CardView.ViewMode { return self == .present ? .card : .extended }
        var next: Transition { return self == .present ? .dismiss : .present }
        var cornerRadius: CGFloat { return self == .present ? 20 : 0 }
    }
}

