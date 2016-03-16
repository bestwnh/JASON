//
//  JSON.swift
//
//  Copyright (c) 2016 Damien (http://delba.io)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

// MARK: - Initializers

public struct JSON {
    /// The object on which any subsequent method operates
    public let object: AnyObject?

    /**
        Creates an instance of JSON from AnyObject.

        - parameter object: An instance of any class

        - returns: the created JSON
    */
    public init(_ object: AnyObject?) {
        self.init(object: object)
    }

    /**
        Creates an instance of JSON from NSData.

        - parameter data: An instance of NSData

        - returns: the created JSON
    */
    public init(_ data: NSData?) {
        self.init(object: JSON.objectWithData(data))
    }

    /**
        Creates an instance of JSON from AnyObject.
        Takes an explicit parameter name to prevent calls to init(_:) with NSData? when nil is passed.

        - parameter object: An instance of any class

        - returns: the created JSON
    */
    internal init(object: AnyObject?) {
        self.object = object
    }
}

// MARK: - Subscript

extension JSON {
    /**
        Creates a new instance of JSON.

        - parameter index: A string

        - returns: a new instance of JSON or itself is object is nil.
    */
    public subscript(index: String) -> JSON {
        if object == nil { return self }

        if let nsDictionary = nsDictionary {
            return JSON(nsDictionary[index])
        }

        return JSON(object: nil)
    }

    /**
        Creates a new instance of JSON.

        - parameter index: A string

        - returns: a new instance of JSON or itself is object is nil.
    */
    public subscript(index: Int) -> JSON {
        if object == nil { return self }

        if let nsArray = nsArray {
            return JSON(nsArray[safe: index])
        }

        return JSON(object: nil)
    }
}

// MARK: - Private extensions

private extension JSON {
    /**
        Converts an instance of NSData to AnyObject.

        - parameter data: An instance of NSData or nil

        - returns: An instance of AnyObject or nil
    */
    static func objectWithData(data: NSData?) -> AnyObject? {
        if let data = data {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: [])
            } catch _ {
                return nil
            }
        }

        return nil
    }
}
