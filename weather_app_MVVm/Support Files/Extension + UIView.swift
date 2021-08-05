
import UIKit

var activityView: UIView?

private let blurEffect: UIVisualEffectView = {
    let blur = UIBlurEffect(style: .dark)
    let view = UIVisualEffectView(effect: blur)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
} ()

extension UIView {
    
    
    func showSpinner() {
        activityView = UIView(frame: self.bounds)
        activityView?.backgroundColor = UIColor.black
        activityView?.alpha = 0.5
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.addSubview(activityView!)
    }

    func removeSpinner() {
        activityView?.removeFromSuperview()
    }
    
    func setupBlur() {
        self.addSubview(blurEffect)
        blurEffect.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        blurEffect.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        blurEffect.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurEffect.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurEffect.alpha = 0.6
    }
    
    func removeBlur() {
        blurEffect.removeFromSuperview()
    }
}


