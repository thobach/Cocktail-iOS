//
//  Cocktail.h
//  cocktail
//
//  Created by Thomas Bachmann on 19.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cocktail : NSManagedObject

@property (nonatomic, retain) NSString * alcLevel;
@property (nonatomic, retain) NSString * calKcal;
@property (nonatomic, retain) NSString * components;
@property (nonatomic, retain) NSString * difficulty;
@property (nonatomic, retain) NSString * glassName;
@property (nonatomic, retain) NSString * glassPhotoUrl;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * instructions;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * photoUrl;
@property (nonatomic, retain) NSString * prepTime;
@property (nonatomic, retain) NSString * volCl;
@property (nonatomic, retain) NSNumber * desired;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSString * tags;
@property (nonatomic, retain) NSString * source;

@end
