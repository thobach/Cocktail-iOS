//
//  Ingredient.h
//  cocktail
//
//  Created by Thomas Bachmann on 19.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSNumber * available;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * products;
@property (nonatomic, retain) NSNumber * inShoppingBasket;
@property (nonatomic, retain) NSNumber * needed;
@property (nonatomic, retain) NSString * name_de;
@property (nonatomic, retain) NSString * name_en;

+(NSArray *)getSections;

@end
