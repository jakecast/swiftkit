import UIKit

public extension UICollectionViewLayout {
    var itemSize: CGSize {
        return self.flowLayout?.itemSize ?? CGSizeZero
    }

    var headerReferenceSize: CGSize {
        return self.flowLayout?.headerReferenceSize ?? CGSizeZero
    }

    var footerReferenceSize: CGSize {
        return self.flowLayout?.footerReferenceSize ?? CGSizeZero
    }

    var contentOffset: CGPoint {
        return self.collectionView?.contentOffset ?? CGPointZero
    }

    var contentSize: CGSize {
        return self.collectionView?.contentSize ?? CGSizeZero
    }

    var contentInset: UIEdgeInsets {
        get {
            return self.collectionView?.contentInset ?? UIEdgeInsetsZero
        }
        set(newValue) {
            self.collectionView?.contentInset = newValue
        }
    }

    var flowLayout: UICollectionViewFlowLayout? {
        return self as? UICollectionViewFlowLayout
    }
}