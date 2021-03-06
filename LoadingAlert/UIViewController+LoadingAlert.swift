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

extension UIViewController {
    
    public func presentLoadingAlertModal(animated: Bool, completion: (() -> Void)?) {
        let viewController = LoadingAlertController()
        present(viewController, animated: animated, completion: completion)
    }
    
    public func dismissLoadingAlertModal(animated: Bool, completion: (() -> Void)?) {
        guard presentedViewController is LoadingAlertController else {
            completion?()
            return
        }
        
        dismiss(animated: animated, completion: completion)
    }
    
    public func bindLoadingAlertModal(to completion: (() -> Void)? = nil) -> (() -> Void) {
        presentLoadingAlertModal(animated: true, completion: nil)
        return { [weak self] in
            self?.dismissLoadingAlertModal(animated: true) {
                completion?()
            }
        }
    }
    
    public func bindLoadingAlertModal<T>(to completion: ((T) -> Void)?) -> ((T) -> Void) {
        presentLoadingAlertModal(animated: true, completion: nil)
        return { [weak self] param in
            self?.dismissLoadingAlertModal(animated: true) {
                completion?(param)
            }
        }
    }
}
