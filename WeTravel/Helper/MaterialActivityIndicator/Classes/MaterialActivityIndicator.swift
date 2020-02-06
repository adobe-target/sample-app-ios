//
//  MaterialActivityIndicator.swift
//  MaterialActivityIndicator
//


import UIKit

@IBDesignable
public class MaterialActivityIndicatorView: UIView {
    @IBInspectable
    public var color: UIColor = .red {
        didSet {
            indicator.strokeColor = color.cgColor
        }
    }

    @IBInspectable
    public var lineWidth: CGFloat = 4.0 {
        didSet {
            indicator.lineWidth = lineWidth
            setNeedsLayout()
        }
    }

    private let indicator = CAShapeLayer()
    private let animator = MaterialActivityIndicatorAnimator()

    private var isAnimating = false
    let vi = UIView.init(frame: UIScreen.main.bounds)

    convenience init() {
        self.init(frame: .zero)
        self.setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
      
        indicator.strokeColor = color.cgColor
        indicator.fillColor = nil
        indicator.lineWidth = lineWidth
        indicator.strokeStart = 0.0
        indicator.strokeEnd = 0.0
        layer.addSublayer(indicator)
    }
}

extension MaterialActivityIndicatorView {
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 35, height: 35)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        vi.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        vi.removeFromSuperview()
        self.superview?.insertSubview(vi, at: 1)
        indicator.frame = bounds
        let diameter = bounds.size.min - indicator.lineWidth
        let path = UIBezierPath(center: bounds.center, radius: diameter / 2)
        indicator.path = path.cgPath
    }
}

extension MaterialActivityIndicatorView {
    public func startAnimating() {
        guard !isAnimating else { return }
        vi.removeFromSuperview()
        self.superview?.insertSubview(vi, at: 1)
        animator.addAnimation(to: indicator)
        isAnimating = true
    }

    public func stopAnimating() {
        guard isAnimating else { return }
        vi.removeFromSuperview()

        animator.removeAnimation(from: indicator)
        isAnimating = false
    }
}
