import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var result = ""
        var counter = 1
        var strCounter = ""
        var skipLength = 0
        var count = 0
        var stack: [String] = []
        
        for (index, char) in message.enumerated() {
            if (skipLength > 0) {
                if index <= skipLength {
                  continue
                }
                else {
                    skipLength = 0
                }
            }
            if char.isASCII && char.isNumber {
                strCounter += [char]
            }
            else if char == "[" {
                let startIdx = String.Index(utf16Offset: index+1, in: message)
               
                var kk = -1
                
                for (k) in index+1...message.count {
                    let charAtPos = message[message.index(message.startIndex, offsetBy: k)]
                    if charAtPos == "]" && count == 0 {
                        kk = k
                        break
                    }
                    if charAtPos == "[" {
                        count += 1
                    }
                    if charAtPos == "]" {
                        count -= 1
                    }
                }
                let endIndex = String.Index(utf16Offset: kk, in: message)
                
                let sub = (String(message[startIdx..<endIndex]))
                stack.append(sub)
                
                let res = decryptMessage(sub)
                
                if (strCounter == "") {
                    counter = 1
                }
                else {
                    counter = Int(strCounter) ?? 0
                }
                
                if (counter>0) {
                    for (_) in [Int](1...counter) {
                        result = result + res
                    }
                }
                skipLength = message.distance(from: message.startIndex, to: endIndex)
                counter = 1
                strCounter = ""
            }
            else {
                result = result + [char]
            }
        }
        
        return result;
    }
}
