

import Vision

@available(iOS 11.0, *)
extension VNRectangleObservation {
    
    //Mark : Calculate the distance between two points and compare, change the allowable areaRating, draw a circle with a point radius of 20, and all four points must be within the allowable straight
    private func caculateTwoPointDistance(pointFirst : CGPoint , pointSecond: CGPoint , allowableValue : CGFloat) -> Bool{
        
        let deltaX = pointFirst.x - pointSecond.x
        let deltaY = pointFirst.y - pointSecond.y
        
        let distance = sqrt(pow(deltaX, 2) + pow(deltaY, 2))
              
        return distance <= allowableValue
    }
    
    //Calculate if all four points are within tolerance
    func comapreTowObservationInRange(target : VNRectangleObservation , toSize : CGSize , allowableValue : CGFloat) -> Bool
    {
        
        let ObservationAry = ["topLeft", "topRight","bottomLeft","bottomRight"]
        
        
        for key in ObservationAry
        {
            let point1 = self.value(forKey: key) as! CGPoint
            let point2 = target.value(forKey: key) as! CGPoint
            
            guard  caculateTwoPointDistance(pointFirst: point1.scaled(to: toSize), pointSecond: point2.scaled(to: toSize), allowableValue: allowableValue) else
                
            {
                return false
            }
        }
        
        return true
        
    }
    
}
