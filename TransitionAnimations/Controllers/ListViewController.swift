//
//  ListViewController.swift
//  TransitionAnimations
//
//  Created by Luis  Costa on 05/08/2019.
//  Copyright © 2019 Luis  Costa. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    // UI
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: ListCell.identifier, bundle: nil), forCellWithReuseIdentifier: ListCell.identifier)
            collectionView.dataSource = listDataSource
            collectionView.delegate = self
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
            collectionView.bounces = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = true
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.numberOfPages = 4
            pageControl.currentPage = 0
            pageControl.currentPageIndicatorTintColor = .darkGray
            pageControl.pageIndicatorTintColor = .lightGray
            pageControl.isUserInteractionEnabled = false
        }
    }
    
    // MARK: Properties
    private let listDataSource = ListDataSource()
    private let animator = TransitionAnimator()
    
    // MARK: Private Functions
    private func instantiateDetailViewController(passing model: Model.Card) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "detail-view-controller") as? DetailViewController else { return }
        
        detailViewController.setCardDetail(model: model, height: collectionView.frame.height)
        detailViewController.transitioningDelegate = self
        detailViewController.modalPresentationStyle = .overFullScreen
        
        present(detailViewController, animated: true, completion: nil)
    }
    
    func getSelectedCardView() -> CardView? {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return nil }
        guard let cell = collectionView.cellForItem(at: indexPath) as? ListCell else { return nil }
        
        return cell.cardView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Model
        let model = listDataSource.requestModel(for: indexPath.item)
        animator.cardModel = model
        instantiateDetailViewController(passing: model)
    }
}

// MARK: - UIScrollViewDelegate
extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageControl(scrollView)
    }
    
    private func updatePageControl(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.bounds.width)
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension ListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        animator.transition = .present
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.transition = .dismiss
        return animator
    }
}
