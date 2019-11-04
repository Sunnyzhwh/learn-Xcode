//
//  ViewController.swift
//  playingcard
//
//  Created by Sunny on 2019/6/24.
//  Copyright © 2019年 Sunny. All rights reserved.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {
    var Deck = PlayingcardDeck()

//    @IBOutlet weak var PlayingCardView: PlayingCardView!{
//        didSet{
//            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
//            swipe.direction = [.left,.right]
//            PlayingCardView.addGestureRecognizer(swipe)
//            let pinch = UIPinchGestureRecognizer(target: PlayingCardView, action: #selector(PlayingCardView.adjustFaceScale(byHandlingGestureRecognizedBy:)))
//            PlayingCardView.addGestureRecognizer(pinch)
//        }
//    }
//    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
//        switch sender.state {
//        case .ended:
//            PlayingCardView.isFaceup = !PlayingCardView.isFaceup
//        default:
//            break
//        }
//
//    }
//    @objc func nextCard(){
//        if let card = Deck.draw(){
//            PlayingCardView.rank = card.rank.order
//            PlayingCardView.suit = card.suit.rawValue
//        }
//    }
    
    @IBOutlet var cardViews: [PlayingCardView]!
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior(in: animator)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CMMotionManager.shared.isAccelerometerAvailable {
            cardBehavior.gravityBehavior.magnitude = 1.0
            CMMotionManager.shared.accelerometerUpdateInterval = 1/10
            CMMotionManager.shared.startAccelerometerUpdates(to: .main) { (data, error) in
                if var x = data?.acceleration.x, var y = data?.acceleration.y {
                    switch UIDevice.current.orientation {
                    case .portrait: y *= -1
                    case .portraitUpsideDown: break
                    case .landscapeRight: swap(&x, &y)
                    case .landscapeLeft: swap(&x, &y); y *= -1
                    default: x = 0; y = 0;
                    }
                    self.cardBehavior.gravityBehavior.gravityDirection = CGVector(dx: x, dy: y)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cardBehavior.gravityBehavior.magnitude = 0
        CMMotionManager.shared.stopAccelerometerUpdates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cards = [Playingcard]()
        for _ in 1...((cardViews.count + 1)/2){
            let card = Deck.draw()!
            cards += [card,card]
        }
        for cardView in cardViews {
            cardView.isFaceup = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            cardBehavior.addItem(cardView)
            
        }

    }
    private var faceUpCardViews: [PlayingCardView]{
        return cardViews.filter{ $0.isFaceup && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0) && $0.alpha == 1 }
    }
    private var faceUpCardViewsMatch : Bool{
        return faceUpCardViews.count == 2 &&
        faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
        faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    var lastChosenCardView: PlayingCardView?
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let chosenCardView = recognizer.view as? PlayingCardView, faceUpCardViews.count < 2 {
                lastChosenCardView = chosenCardView
                cardBehavior.removeItem(chosenCardView)
                UIView.transition(with: chosenCardView,
                                  duration: 0.6,
                                  options: .transitionFlipFromLeft,
                                  animations: {chosenCardView.isFaceup = !chosenCardView.isFaceup},
                                  completion: { finished in
                                    let cardsToAnimate = self.faceUpCardViews
                                    if self.faceUpCardViewsMatch{
                                        UIViewPropertyAnimator.runningPropertyAnimator(
                                            withDuration: 0.6,
                                            delay: 0,
                                            options: [],
                                            animations: {
                                                cardsToAnimate.forEach{
                                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
                                                    }
                                                
                                            },
                                            completion: { position in
                                                UIViewPropertyAnimator.runningPropertyAnimator(
                                                    withDuration: 0.8,
                                                    delay: 0,
                                                    options: [],
                                                    animations: {
                                                        cardsToAnimate.forEach{
                                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                            $0.alpha = 0
                                                        }
                                                },completion: { position in
                                                    cardsToAnimate.forEach{
                                                        $0.isHidden = true
                                                        $0.alpha = 1
                                                        $0.transform = .identity
                                                    }
                                                    
                                                })
                                                
                                        }
                                    )
                                    }else if cardsToAnimate.count == 2 {
                                        if chosenCardView == self.lastChosenCardView {
                                            cardsToAnimate.forEach{ cardView in
                                                UIView.transition(with: cardView,
                                                                  duration: 0.6,
                                                                  options: .transitionFlipFromLeft,
                                                                  animations: {cardView.isFaceup = false},
                                                                  completion: { finished in
                                                                    self.cardBehavior.addItem(cardView)
                                                                    
                                                                }
                                                            )
                                            }
                                        }
                                    }else {
                                        if !chosenCardView.isFaceup {
                                            self.cardBehavior.addItem(chosenCardView)
                                        }
                                    }
                                    
                }
                )
                
            }
        default:
            break
        }
    }

}
extension CGFloat{
    var arc4random: CGFloat{
        if self > 0{
            return CGFloat(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -CGFloat(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}
