import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {

        var maxDistance = 0
        
        var foodMatrix = [[Int]](repeating: [Int](repeating: 0, count: maxWeight+1), count: foods.count)
        
        for (indexFood) in 0..<foods.count {
            
            for (indexWeight) in 1..<maxWeight+1 {
                var prevMax = 0;
                var prevAnotherValue = 0
                let currentWeight = foods[indexFood].weight
                let currentValue = foods[indexFood].value
                
                if (indexFood-1) >= 0 {
                    prevMax = foodMatrix[indexFood-1][indexWeight]
                    
                    if (indexWeight >= currentWeight) {
                        prevAnotherValue = foodMatrix[indexFood-1][indexWeight - currentWeight]
                    }
                }
                if indexWeight >= currentWeight {
                    foodMatrix[indexFood][indexWeight] = max(prevMax, currentValue + prevAnotherValue)
                }
                else {
                    foodMatrix[indexFood][indexWeight] = prevMax
                }
            }
        }
        
//        print(foodMatrix)
        
        
        var drinkMatrix = [[Int]](repeating: [Int](repeating: 0, count: maxWeight+1), count: drinks.count)
        
        for (indexDrink) in 0..<drinks.count {
            
            for (indexWeight) in 1..<maxWeight+1 {
                var prevMax = 0;
                var prevAnotherValue = 0
                let currentWeight = drinks[indexDrink].weight
                let currentValue = drinks[indexDrink].value
                
                if (indexDrink-1) >= 0 {
                    prevMax = drinkMatrix[indexDrink-1][indexWeight]
                    
                    if indexWeight >= currentWeight {
                        prevAnotherValue = drinkMatrix[indexDrink-1][indexWeight - currentWeight]
                    }
                }
                
                if indexWeight >= currentWeight {
                    drinkMatrix[indexDrink][indexWeight] = max(prevMax, currentValue + prevAnotherValue)
                }
                else {
                    drinkMatrix[indexDrink][indexWeight] = prevMax
                }
            }
        }
        
//        print(drinkMatrix)
        
        for counter in 0..<maxWeight+1 {
            let currentFoodDistance = foodMatrix[foods.count-1][counter]
            let currentDrinkDistance = drinkMatrix[drinks.count-1][maxWeight - counter]
            var distance = currentFoodDistance
            
            if currentDrinkDistance<currentFoodDistance {
                distance = currentDrinkDistance
            }
            if (distance > maxDistance) {
                maxDistance = distance
            }
            
        }
        
        return maxDistance
    }
    
}

