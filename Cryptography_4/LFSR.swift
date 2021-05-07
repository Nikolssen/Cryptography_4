//
//  LFSR.swift
//  Cryptography_4
//
//  Created by Admin on 07.05.2021.
//

import Foundation

class LFSR
{
    
    func encrypt(message: String) -> (pattern: [UInt8], cypher: [UInt8])
    {
       
        let data = Data(message.utf8)
        let size = data.count
        var input = Array<UInt8>(repeating: 0, count: size/MemoryLayout<UInt8>.stride)
        _ = input.withUnsafeMutableBytes({data.copyBytes(to: $0)})
        
        let key = getPseudoRandomSequence(byteSize: input.count)

        var output = Array<UInt8>()
        for i in 0..<input.count
        {
            let number = input[i] ^ key[i]
            output.append(number)
        }
        return (key, output)
    }
    
    private func getXORResult(number: UInt32) -> Bool {
        //26th, 8th, 7th, 1st bytes
        var counter = 0
        if (number & 0x2000000) != 0
            {counter+=1}
        if (number & 0x80) != 0
            {counter+=1}
        if (number & 0x40) != 0
            {counter+=1}
        if (number & 0x1) != 0
            {counter+=1}
        return (counter % 2) == 1
    }
    
    func decrypt(cypher: [UInt8]) -> String {
        let key = getPseudoRandomSequence(byteSize: cypher.count)
        
        var output = Array<UInt8>()
        for i in 0..<cypher.count
        {
            let number = cypher[i] ^ key[i]
            output.append(number)
        }
        
        let result = String(decoding: output, as: UTF8.self)
        return result
    }
    
    private func getPseudoRandomSequence(byteSize: Int) -> [UInt8]
    {
        var byteMask: UInt32 = 0x3FFFFFF //26 bits
        var key: Array<UInt8> = [0xFF, 0xFF, 0xFF]
        var currentBit = 6

        while (byteSize != key.count){
            if getXORResult(number: byteMask) {
                byteMask = byteMask << 1 + 1
            }
            else
            {
                byteMask<<=1
            }
            currentBit-=1
            if currentBit == 0
            {
                let number: UInt8 = UInt8(byteMask & 0xFF)
                key.append(number)
                currentBit = 8
            }
        }
        return key
    }
}
