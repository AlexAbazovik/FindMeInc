import UIKit

@IBDesignable
public class CustomRadioButton: UIButton {
    
    internal var outerShape = CAShapeLayer()
    internal var innerShape = CAShapeLayer()
    
    //Shape color
    @IBInspectable public var outerShapeColor: UIColor = UIColor.white{
        didSet{
            outerShape.strokeColor = outerShapeColor.cgColor
        }
    }
    
    @IBInspectable public var innerShapeColor: UIColor = UIColor.white{
        didSet{
            innerShape.strokeColor = innerShapeColor.cgColor
            
        }
    }
    
    //Shape line width
    @IBInspectable public var outerShapeLineWidth: CGFloat = 1.0{
        didSet{
            setShapeLayouts()
        }
    }
    
    @IBInspectable public var innerShapeLineWidth: CGFloat = 1.0{
        didSet{
            setShapeLayouts()
        }
    }
    
    private func setShapeLayouts() {
        outerShape.frame = bounds
        outerShape.lineWidth = outerShapeLineWidth
        outerShape.path = shapePath.cgPath
        
        innerShape.frame = bounds
        innerShape.lineWidth = innerShapeLineWidth
        innerShape.path = fillShapePath.cgPath
    }
    
    private var shapePath: UIBezierPath {
        return UIBezierPath(rect: setFrame)
    }
    
    private var fillShapePath: UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: outerShapeLineWidth + 2.0 , y: outerShapeLineWidth + 2.0))
        path.addLine(to: CGPoint(x: outerShape.frame.maxX - outerShapeLineWidth, y: outerShape.frame.maxY - outerShapeLineWidth))
        
        path.move(to: CGPoint(x: outerShapeLineWidth + 2.0, y: outerShape.frame.maxY - outerShapeLineWidth))
        path.addLine(to: CGPoint(x: outerShape.frame.maxX - outerShapeLineWidth, y: outerShapeLineWidth + 2.0))
        
        return path
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInitialization()
    }
    
    private var setFrame: CGRect {
        let width = bounds.width
        let height = bounds.height
        
        let x: CGFloat = 1.0
        let y: CGFloat = 1.0
    
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func customInitialization() {
        outerShape.frame = bounds
        outerShape.lineWidth = outerShapeLineWidth
        outerShape.fillColor = UIColor.clear.cgColor
        outerShape.strokeColor = outerShapeColor.cgColor
        layer.addSublayer(outerShape)
        
        innerShape.frame = bounds
        innerShape.lineWidth = innerShapeLineWidth
        innerShape.fillColor = innerShapeColor.cgColor
        innerShape.strokeColor = innerShapeColor.cgColor
        layer.addSublayer(innerShape)
        
        setFillState()
    }
    
    private func setFillState() {
        if self.isSelected {
            innerShape.isHidden = false
        } else {
            innerShape.isHidden = true
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setShapeLayouts()
    }
    
    override public var isSelected: Bool {
        didSet {
            setFillState()
        }
    }
    
}
