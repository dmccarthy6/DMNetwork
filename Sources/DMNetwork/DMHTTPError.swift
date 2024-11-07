//
//  DMHTTPError.swift
//  DMNetwork
//
//  Created by Dylan  on 11/7/24.
//

import Foundation

enum DMHTTPError: Error {
    case unknown

#warning("TODO: IOS-003 - Custom HTTP Error")
}

/* APPLE DOCS - Decoding Error

 case dataCorrupted(DecodingError.Context)
 An indication that the data is corrupted or otherwise invalid.
 case keyNotFound(any CodingKey, DecodingError.Context)
 An indication that a keyed decoding container was asked for an entry for the given key, but did not contain one.
 case typeMismatch(any Any.Type, DecodingError.Context)
 An indication that a value of the given type could not be decoded because it did not match the type of what was found in the encoded payload.
 case valueNotFound(any Any.Type, DecodingError.Context)
 An indication that a non-optional value of the given type was expected, but a null value was found.
 */
