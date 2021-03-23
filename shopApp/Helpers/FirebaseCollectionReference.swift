//
//  FirebaseCollectionReference.swift
//  shopApp
//
//  Created by Jahongir on 9/11/20.
//  Copyright © 2020 Jahongir. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
    
}

func FirebaseReference(_ collectionReference: FCollectionReference)
    -> CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
}
