//
//  RetiredGOT.h
//  GameOfThronesCharacter
//
//  Created by Alex Santorineos on 6/2/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetiredGOT : NSObject
@property NSString *character;
@property NSString *actor;


-(instancetype)initWithdict:(NSDictionary *)dict;
+(void)retrieveSuperheroesWithCompletion:(void(^)(NSArray*))complete;

@end
