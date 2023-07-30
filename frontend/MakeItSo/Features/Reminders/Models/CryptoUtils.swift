//
//  CryptoUtils.swift
//  MakeItSo
//
//  Created by madeinweb on 29/07/23.
//

import Foundation
import CommonCrypto

class CryptoUtils {
    // Método estático para gerar um nonce aleatório
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Erro ao gerar número aleatório: \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }
    
    static func sha256(_ input: String) -> String {
           if let inputData = input.data(using: .utf8) {
               var hashData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
               _ = hashData.withUnsafeMutableBytes { hashBytes in
                   inputData.withUnsafeBytes { dataBytes in
                       CC_SHA256(dataBytes.baseAddress, CC_LONG(inputData.count), hashBytes.bindMemory(to: UInt8.self).baseAddress)
                   }
               }

               let hashString = hashData.map { String(format: "%02hhx", $0) }.joined()
               return hashString
           }
           return ""
       }
}

