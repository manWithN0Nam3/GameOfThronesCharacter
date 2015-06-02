//
//  RetiredGOT.m
//  GameOfThronesCharacter
//
//  Created by Alex Santorineos on 6/2/15.
//  Copyright (c) 2015 madApperz. All rights reserved.
//

#import "RetiredGOT.h"

@implementation RetiredGOT

-(instancetype)initWithdict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.actor = [dict objectForKey:@"actor"];
        self.character = [dict objectForKey:@"character"];


    }
    return self;


}

+(void)retrieveSuperheroesWithCompletion:(void(^)(NSArray*))complete{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"gameofthrones123"
                                                     ofType:@"plist"];
   NSArray* names = [[NSArray alloc]
                  initWithContentsOfFile:path];
    NSMutableArray *mutable = [NSMutableArray new];

    for (NSDictionary *dict in names) {
        RetiredGOT *retiredGot = [[RetiredGOT alloc]initWithdict:dict];
        [mutable addObject:retiredGot];
}


//    NSArray *array = [NSArray arrayWithArray:mutable];

    complete(mutable);

}

@end
