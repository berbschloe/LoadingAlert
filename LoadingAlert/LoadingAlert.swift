//
//  LoadingAlert
//
//  Copyright (c) 2020 - Present Brandon Erbschloe - https://github.com/berbschloe
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

private let kCornerRadius: CGFloat = 13
private let kSpan: CGFloat = 100

public class LoadingAlertController: UIViewController {
    
    public static var defaultActivityIndicatorColor: UIColor = .init(red: 0.58, green: 0.58, blue: 0.59, alpha: 1)
    public static var defaultBackgroundStyle: UIBlurEffect.Style = .extraLight
    
    private let backgroundView: UIVisualEffectView
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private let transition = LoadingAlertTransition()
    
    public init(activityIndicatorColor: UIColor? = nil, backgroundStyle: UIBlurEffect.Style? = nil) {
        
        self.backgroundView = UIVisualEffectView(effect: UIBlurEffect(
            style: backgroundStyle ?? LoadingAlertController.defaultBackgroundStyle
        ))
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transition
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = kCornerRadius
        backgroundView.layer.masksToBounds = true
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        
        activityIndicatorView.color = activityIndicatorColor ?? LoadingAlertController.defaultActivityIndicatorColor
        
        view.addSubview(backgroundView)
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            
            backgroundView.widthAnchor.constraint(equalToConstant: kSpan),
            backgroundView.widthAnchor.constraint(equalTo: backgroundView.heightAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicatorView.startAnimating()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        activityIndicatorView.stopAnimating()
    }
}
