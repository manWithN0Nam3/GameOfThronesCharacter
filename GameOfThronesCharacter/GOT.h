//
//  GOT.h
//  GameOfThronesCharacter
//
//  Created by Alex Santorineos on 6/2/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GOT : NSManagedObject

@property (nonatomic, retain) NSString * character;
@property (nonatomic, retain) NSString * actor;

@end
