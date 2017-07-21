import Foundation
import CryptoSwift

extension String {
 
    //    let inputBytes: [UInt8] = Array("secret".utf8)
    //    let key:        [UInt8] = Array("secret0key000000".utf8) //16
    //    let iv:         [UInt8] = Array("0000000000000000".utf8)  //16
    //
    //    var encryptedBase64 = ""
    //    do {
    //    let encrypted: [UInt8] = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt(inputBytes)
    //    let encryptedNSData = NSData(bytes: encrypted, length: encrypted.count)
    //    encryptedBase64 = encryptedNSData.base64EncodedString(options: [])
    //
    //    let decrypted: [UInt8] = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).decrypt(encrypted)
    //    let result = String(bytes: decrypted, encoding: String.Encoding.utf8)!
    //    print("result:\t\(result )")
    //    } catch {
    //    // some error
    //    }
    //    print("encryptedBase64: \(encryptedBase64)")
    
    func encryptAES(key: String, iv: String) throws -> String{
        
        do {
            let inputBytes = [UInt8](self.utf8)
            let encrypted: [UInt8] = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt(inputBytes)
            let encryptedNSData = NSData(bytes: encrypted, length: encrypted.count)
            let encryptedBase64 = encryptedNSData.base64EncodedString(options: [])
            return encryptedBase64
        }
        catch{
            // some error
            return "error"
        }
        
    }
    
    func decryptAES(key: String, iv: String) throws -> String {
        do {
            let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
            let decrypted: [UInt8] = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).decrypt(data!.bytes)
            let result = String(bytes: decrypted, encoding: String.Encoding.utf8)!
            return result
        }
        catch{
            // some error
            return "error"
        }
    }
    
    /*
    func aesEncrypt(key: String, iv: String) throws -> String{
        let data = self.data(using: String.Encoding.utf8)
        let enc: [UInt8] = try AES(key: key, iv: iv, blockMode:.CBC, padding: PKCS7()).encrypt(data!.bytes)
        let encData = NSData(bytes: enc, length: Int(enc.count))
        let base64String: String = encData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0));
        let result = String(base64String)
        return result!
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let audioData = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
//        let datac = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        let dec: [UInt8] = try AES(key: key, iv: iv, blockMode:.CBC, padding: PKCS7()).decrypt(audioData!.bytes)
        let decData = NSData(bytes: dec, length: Int(dec.count))
        let result = NSString(data: decData as Data, encoding: String.Encoding.utf8.rawValue)
        return String(result!)
    }
    */
}
