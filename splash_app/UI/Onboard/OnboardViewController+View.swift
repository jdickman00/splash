//
//  OnboardViewController+FixedContent.swift
//  splash
//
//  Created by Gonzo Fialho on 14/03/19.
//  Copyright © 2019 Gonzo Fialho. All rights reserved.
//

import UIKit

extension OnboardViewController {

    enum ButtonState: String {
        case `continue`
        case finish

        var title: String {
            return rawValue.capitalizingFirstLetter()
        }
    }

    class FixedView: UIView {

        var buttonState: ButtonState = .continue {
            didSet {
                continueButton.setTitle(buttonState.title, for: .normal)
            }
        }

        let continueButton = UIButton(type: .system)
        let pageControl = UIPageControl()
        let bottomView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))

        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            return bottomView.hitTest(self.convert(point, to: bottomView), with: event)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)

            setup()
        }

        required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}

        private func setup() {
            setupBottomView()
            setupPageControl()
            setupContinueButton()
        }

        private func setupBottomView() {
            bottomView.setupForAutoLayout(in: self)

            bottomView.leftAnchor.constraint(equalTo: leftAnchor).activate()
            bottomView.rightAnchor.constraint(equalTo: rightAnchor).activate()
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
        }

        private func setupPageControl() {
            pageControl.setupForAutoLayout(in: bottomView.contentView)
            pageControl.bottomAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.bottomAnchor,
                                                constant: 0).activate()
            pageControl.centerXAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.centerXAnchor).activate()

            pageControl.pageIndicatorTintColor = .lightGray
            pageControl.currentPageIndicatorTintColor = .black
            pageControl.addTarget(nil,
                                  action: #selector(OnboardViewController.pageControlChanged(sender:)),
                                  for: .valueChanged)
        }

        private func setupContinueButton() {
            continueButton.setupForAutoLayout(in: bottomView.contentView)

            continueButton.setTitle(buttonState.title, for: .normal)
            continueButton.addTarget(nil,
                                     action: #selector(OnboardViewController.advance),
                                     for: .touchUpInside)

            continueButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            continueButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).activate()
            continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -4).activate()
            continueButton.topAnchor.constraint(equalTo: bottomView.contentView.topAnchor,
                                                constant: 8).activate()
        }
    }
}
