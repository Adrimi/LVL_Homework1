//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class MyViewController : UIViewController, UIGestureRecognizerDelegate {
    
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var movingCircle: UIView = UIView()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        tap.numberOfTapsRequired = 2
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleDoubleTap(_ tap: UITapGestureRecognizer) {
        
        // Spawn Circle
        let size: CGFloat = CGFloat(100)
        let circle =
            UIView(frame:
                CGRect(origin: .zero, size:
                    CGSize(width: size, height: size)))
        circle.center = tap.location(in: view)
        circle.backgroundColor = UIColor.randomBrightColor()
        circle.layer.cornerRadius = size * 0.5
        
        view.addSubview(circle)
        animate(circle, case: "Appear")
        
        // Add gestures to circle
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap(_:)))
        tripleTap.numberOfTapsRequired = 3
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        circle.addGestureRecognizer(tripleTap)
        circle.addGestureRecognizer(longPress)
    }
    
    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        animate(tap.view!, case: "Destroy")
        print("Triple Tap!")
    }
    
    @objc func handleLongPress(_ press: UILongPressGestureRecognizer) {
        
        switch press.state {
        case .began:
            
            // get only once the view of the circle (performance friendly)
            movingCircle = press.view!
            
            // move it on the top of another (esthetics)
            view.bringSubviewToFront(movingCircle)
            
            // pos relative to the center of UI
            x = press.location(in: view).x - movingCircle.center.x
            y = press.location(in: view).y - movingCircle.center.y
            
            animate(movingCircle, case: "Grab")
            
        case .changed:
            
            // Moving circle
            movingCircle.center.x = press.location(in: view).x - x
            movingCircle.center.y = press.location(in: view).y - y
            
        case .ended:
            animate(movingCircle, case: "Put")
        default:
            print("Unknown state of the LongPress!")
        }
    }
    
    // animation function must be very concern about the View want to animate
    // there's no option there to be optional (and unwrapping to have less complicated code)
    func animate(_ view: UIView, case mode: String) {
        switch mode {
        case "Appear":
            view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            view.alpha = 0.0
            UIView.animate(withDuration: 0.15, animations: {
                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                view.alpha = 1.0
            }, completion: { completed in
                UIView.animate(withDuration: 0.1, animations: {
                    view.transform = .identity
                })
            })
        case "Destroy":
            UIView.animate(withDuration: 0.1, animations: {
                view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                view.alpha = 0.0
            }, completion: { completed in
                view.removeFromSuperview()
            })
        case "Grab":
            UIView.animate(withDuration: 0.2, animations: {
                view.alpha = 0.8
                view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        case "Put":
            UIView.animate(withDuration: 0.2, animations: {
                view.alpha = 1
                view.transform = .identity
            })
        default:
            print("Something wrong with animation key, use proper one!")
        }
    }
    
    // delegate function that compares the double and triple tap on the screen
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if(gestureRecognizer is UITapGestureRecognizer && otherGestureRecognizer is UITapGestureRecognizer) {
            if (gestureRecognizer as! UITapGestureRecognizer).numberOfTapsRequired == 2 &&
                (otherGestureRecognizer as! UITapGestureRecognizer).numberOfTapsRequired == 3{
                return true
            }
        }
        return false
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return random(min: 0.0, max: 1.0)
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(max > min)
        return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
    }
}

extension UIColor {
    static func randomBrightColor() -> UIColor {
        return UIColor(hue: .random(),
                       saturation: .random(min: 0.5, max: 1.0),
                       brightness: .random(min: 0.7, max: 1.0),
                       alpha: 1.0)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

