import Foundation

class StockMaximize {
    
    func countProfit(prices: [Int]) -> Int {
        
        var result: Int = 0
        var cnt = 0
        
        while (cnt < prices.count) {
            
            let price = prices[cnt]
            
            var max = 0
            var nextMaxFound = false
            var cnt2 = cnt+1
            
            while (cnt2 < prices.count) {
                if prices[cnt2] < price {
                    if nextMaxFound {
                        break
                    }
                }
                if prices[cnt2] > price {
                    if (nextMaxFound) {
                        if (prices[cnt2] > max) {
                            max = prices[cnt2]
                        }
                    }
                    else {
                        max = prices[cnt2]
                        nextMaxFound = true
                    }
                }
                cnt2 += 1
            }
            if (nextMaxFound) {
                result += max - price
                max = 0
                nextMaxFound = false
            }
            cnt += 1
        }
        
        return result
    }
}
