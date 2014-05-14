//
//  Ingredient.m
//  cocktail
//
//  Created by Thomas Bachmann on 19.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ingredient.h"


@implementation Ingredient

@dynamic available;
@dynamic category;
@dynamic name;
@dynamic products;
@dynamic inShoppingBasket;
@dynamic needed;
@dynamic name_de;
@dynamic name_en;

+ (NSArray *) getSections
{
    NSArray *sections = [NSArray arrayWithObjects:@"AlcoholAbove30PercentKey", @"AlcoholBelow29PercentKey",@"SyrupsKey",@"SodasKey",@"FruitsAndVegtablesKey",@"DairyKey",@"SugarKey",@"OtherKey",@"JuicesKey", nil];
    return sections;
}

@end
