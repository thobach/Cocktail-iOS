//
//  ShoppingTableViewController.m
//  cocktail
//
//  Created by Thomas Bachmann on 19.09.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShoppingTableViewController.h"
#import "CocktailDetailViewController.h"
#import "AppDelegate.h"
#import "Ingredient.h"
#import "Cocktail.h"

@interface ShoppingTableViewController ()

@end

@implementation ShoppingTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize fetchedResultsControllerCocktail = _fetchedResultsControllerCocktail;
@synthesize tvCell = _tvCell;

- (NSArray *) getSections
{
    NSArray *sections = [NSArray arrayWithObjects:NSLocalizedString(@"Desired Cocktails",nil), NSLocalizedString(@"Needed Ingredients",nil), NSLocalizedString(@"Ingredients For Desired Cocktails Available At Home",nil), nil];
    return sections;
}

- (NSFetchedResultsController *) fetchedResultsController{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if(_fetchedResultsController){
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Ingredient" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:NSLocalizedString(@"sortIngredientKey",nil) ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescription, nil];
    [fetchRequest setSortDescriptors: sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Ingredient"];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSFetchedResultsController *) fetchedResultsControllerCocktails{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    if(_fetchedResultsControllerCocktail){
        return _fetchedResultsControllerCocktail;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cocktail" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"desired == \"1\""];
    [fetchRequest setPredicate:searchPredicate];
    
    NSSortDescriptor *sortDescription = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescription, nil];
    [fetchRequest setSortDescriptors: sortDescriptors];
    
    _fetchedResultsControllerCocktail = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsControllerCocktail.delegate = self;
    
    return _fetchedResultsControllerCocktail;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *btnClear = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Clear List",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(clear)];    
        self.navigationItem.rightBarButtonItem = btnClear;
        
        UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        navLabel.backgroundColor = [UIColor clearColor];
        navLabel.textColor = [UIColor whiteColor];
        navLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        navLabel.font = [UIFont fontWithName:@"TeenLight-Regular" size:26];
        navLabel.textAlignment = UITextAlignmentCenter;
        navLabel.text = NSLocalizedString(@"Shopping List", nil);
        self.navigationItem.titleView = navLabel;
        self.title = NSLocalizedString(@"Shopping List", nil);
        
        self.tabBarItem.image = [UIImage imageNamed:@"tab_shoppinglist_small_white"];
    }
    
    // load all ingredients
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Could not retrieve ingredients from databases");
    }
    
    [self updateBadge];
    
    // register observer for filter notification
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(filterUpdated) name:@"FilterUpdated" object:nil];
    [defaultCenter addObserver:self selector:@selector(filterUpdated) name:@"ShoppingListUpdated" object:nil];
    
    return self;
}


-(void) clear
{
    // array with indexes to all desired cocktails
    NSMutableArray *indexPaths = [NSMutableArray array];
    int count = 0;
    for(Cocktail *undesiredCocktail in [self.fetchedResultsControllerCocktail fetchedObjects]){
        // remove desired flag from all desired cocktails
        undesiredCocktail.desired = nil;
        [indexPaths addObject: [NSIndexPath indexPathForRow:count inSection:0]];
        count++;
    }
    
    // remove needed flag from all needed ingredients
    // needed and not available
    int section = 2; // offset = 2
    for(NSString *sectionName in [Ingredient getSections]){
        int rowCount = -1;
        for(Ingredient *ingredient in [[self fetchedResultsController] fetchedObjects]){
            if([ingredient.needed intValue] == 1 && [ingredient.available intValue] != 1 && [ingredient.category isEqualToString:sectionName]){
                ingredient.needed = nil;
                rowCount++;
                [indexPaths addObject: [NSIndexPath indexPathForRow:rowCount inSection:section]];
            }
        }
        section++;
    }
    // needed and available
    int rowCount = -1;
    section = [[Ingredient getSections]count] + 2;
    for(Ingredient *ingredient in [[self fetchedResultsController] fetchedObjects]){
        if([ingredient.needed intValue] == 1 && [ingredient.available intValue] == 1){
            ingredient.needed = nil;
            rowCount++;
            [indexPaths addObject: [NSIndexPath indexPathForRow:rowCount inSection:section]];
        }
    }
    
    // persist changes
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
    
    // reload all desired cocktails
    NSError *error;
    if(![self.fetchedResultsControllerCocktail performFetch:&error]){
        NSLog(@"Could not retrieve desired cocktails from databases");
    }
    
    [self updateBadge];
    
    // update cocktail detail view via notification
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"ShoppingListCleared" object:nil];
    
    // update view
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // start in editing mode
    self.editing = YES;
    
    // show navigation bar
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    // load all ingredients
    NSError *error1;
    if(![self.fetchedResultsController performFetch:&error1]){
        NSLog(@"Could not retrieve ingredients from databases");
    }
    
    [self updateBadge];
    
    [self.tableView reloadData];
    self.tableView.scrollEnabled = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
}

-(void)updateBadge
{
    // get number of needed ingredients
    int numberOfNeededIngredients = 0;
    for(Ingredient *ingredient in [[self fetchedResultsController] fetchedObjects]){
        if([ingredient.needed intValue] == 1 && [ingredient.available intValue] != 1){
            numberOfNeededIngredients++;
        }
    }
    self.tabBarItem.badgeValue = [NSString stringWithFormat: @"%d", numberOfNeededIngredients];
}

-(void)filterUpdated
{
    // load all desired cocktails
    NSError *error;
    if(![self.fetchedResultsControllerCocktail performFetch:&error]){
        NSLog(@"Could not retrieve desired cocktails from databases");
    }
    
    [self updateBadge];
    
    [self.tableView reloadData];   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // load all desired cocktails
    NSError *error;
    if(![self.fetchedResultsControllerCocktail performFetch:&error]){
        NSLog(@"Could not retrieve desired cocktails from databases");
    }
    
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self getSections] count] + [[Ingredient getSections] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section    
{
    CGRect headerViewRect = CGRectMake(0.0,0.0,320,24);
    UIView* headerView = [[UIView alloc] initWithFrame:headerViewRect];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0,  5.0, 280 , 14)];
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
    
    // super sections
    if(section < 2){
        label.text = [[self getSections] objectAtIndex:section];
        headerView.backgroundColor = [UIColor darkGrayColor];
    }
    // sub sections (ingredient categories)
    else if(section > 1 && section < [[Ingredient getSections] count] + 2){
        label.text = NSLocalizedString([[Ingredient getSections] objectAtIndex:section - 2],nil);
        headerView.backgroundColor = [UIColor lightGrayColor];
    }
    // super sections
    else {
        label.text = [[self getSections] objectAtIndex:section - [[Ingredient getSections] count]];
        headerView.backgroundColor = [UIColor darkGrayColor];
    }
    
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        // desired cocktails
        return [[[self fetchedResultsControllerCocktails] fetchedObjects] count];
    } else if(section > 1 && section < [[Ingredient getSections] count] + 2){
        // needed ingredients
        int count = 0;
        for(Ingredient *ingredient in [[self fetchedResultsController] fetchedObjects]){
            // ingredient.available must be compared with != 1, because it can also be nil (not only 0)
            if([ingredient.needed intValue] == 1 && [ingredient.available intValue] != 1 && [ingredient.category isEqualToString:[[Ingredient getSections] objectAtIndex:section - 2]]){
                count++;
            }
        }
        return count;
    } else if(section == [[Ingredient getSections] count] + 2) {
        // available at home
        int count = 0;
        for(Ingredient *ingredient in [[self fetchedResultsController] fetchedObjects]){
            if([ingredient.available intValue] == 1 && [ingredient.needed intValue] == 1){
                count++;
            }
        }
        return count;
        
    }
    return 0;
}

- (void)availableIngredient:(Ingredient **)ingredient atIndexPath:(NSIndexPath *)indexPath
{
    // determine which Ingredient should be displayed
    int neededCount = -1;
    
    for(Ingredient *potentialIngredient in [[self fetchedResultsController] fetchedObjects]){
        if([potentialIngredient.available intValue] == 1 && [potentialIngredient.needed intValue] == 1){
            neededCount++;
        }
        if(neededCount == indexPath.row){
            *ingredient = potentialIngredient;
            break;
        }
    }
}

- (UITableViewCell *)setupCellOfTableView:(UITableView *)tableView forIngredient:(Ingredient *)ingredient
{
    static NSString *CellIdentifier = @"IngredientNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"IngredientCell_iPhone" owner:self options:nil];
        cell = _tvCell;
        self.tvCell = nil;
    }
    
    // Configure the cell...
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    label.text = NSLocalizedString(ingredient.name,nil);
    
    label = (UILabel *)[cell viewWithTag:2];
    label.text = NSLocalizedString(ingredient.products,nil);
    return cell;
}

- (void)neededIngredient:(Ingredient **)ingredient forIndexPath:(NSIndexPath *)indexPath
{
    // determine which Ingredient should be displayed
    int neededCount = -1;
    
    for(Ingredient *potentialIngredient in [[self fetchedResultsController] fetchedObjects]){
        if([potentialIngredient.needed intValue] == 1 && [potentialIngredient.available intValue] != 1 && [potentialIngredient.category isEqualToString:[[Ingredient getSections] objectAtIndex:indexPath.section - 2]]){
            neededCount++;
        }
        if(neededCount == indexPath.row){
            *ingredient = potentialIngredient;
            break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        static NSString *CellIdentifier = @"CocktailNameCellSmall";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"CocktailCellSmall_iPhone" owner:self options:nil];
            cell = _tvCell;
            self.tvCell = nil;
        }
        
        // determine which Cocktail should be displayed          
        Cocktail *cocktail = [[[self fetchedResultsControllerCocktails] fetchedObjects] objectAtIndex:indexPath.row];
        
        // Configure the cell...
        UILabel *label = (UILabel *)[cell viewWithTag:3];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:label.font.pointSize];
        label.text = cocktail.name;
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:2];
        imageView.image = [UIImage imageNamed:cocktail.photoUrl];
        
        return cell;
    } else if(indexPath.section > 1 && indexPath.section < [[Ingredient getSections] count] + 2){
        
        Ingredient *ingredient;
        [self neededIngredient:&ingredient forIndexPath:indexPath];
        
        UITableViewCell *cell;
        cell = [self setupCellOfTableView:tableView forIngredient:ingredient];
        
        if([ingredient.inShoppingBasket intValue] == 1){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone]; 
        }
        
        return cell;
    } else {
        
        Ingredient *ingredient;
        [self availableIngredient:&ingredient atIndexPath:indexPath];
        
        UITableViewCell *cell;
        cell = [self setupCellOfTableView:tableView forIngredient:ingredient];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone]; 
        
        return cell;
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 40;
    } else {
        return 66;
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // allow moving up the ingredients that are already available
    if(indexPath.section == [[Ingredient getSections] count] + 2){
        return YES;
    } else {
        return NO;
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

// only allow moving to other section (not within same section) 
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if( sourceIndexPath.section == proposedDestinationIndexPath.section )
    {
        return sourceIndexPath;
    }
    else
    {
        return proposedDestinationIndexPath;
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Ingredient *selectedIngredient;
    int count = -1;
    for(Ingredient *potentialIngredient in [self.fetchedResultsController fetchedObjects]){
        if([potentialIngredient.available intValue] == 1 && [potentialIngredient.needed intValue] == 1){
            count++;
        }
        if(count == fromIndexPath.row){
            selectedIngredient = potentialIngredient;
            break;
        }
    }
    selectedIngredient.available = nil;
    
    // persist changes
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
    
    // update house bar via notification
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"HouseBarUpdated" object:nil];
    [defaultCenter postNotificationName:@"FilterUpdated" object:nil];
    
    [self updateBadge];
    
    // refresh cell
    [tableView reloadData];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == [[Ingredient getSections] count] + 2){
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cocktail selected
    if(indexPath.section == 0){
        CocktailDetailViewController *detailViewController = [[CocktailDetailViewController alloc] initWithNibName:@"CocktailDetailCell_iPhone" bundle:nil];
        detailViewController.cocktail = [[self.fetchedResultsControllerCocktail fetchedObjects] objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    // needed ingredient selected
    else if(indexPath.section > 1 && indexPath.section < [[Ingredient getSections] count] + 2){
        Ingredient *selectedIngredient;
        int count = -1;
        for(Ingredient *potentialIngredient in [self.fetchedResultsController fetchedObjects]){
            if([potentialIngredient.needed intValue] == 1 && [potentialIngredient.category isEqualToString:[[Ingredient getSections] objectAtIndex:indexPath.section - 2]]){
                count++;
            }
            if(count == indexPath.row){
                selectedIngredient = potentialIngredient;
                break;
            }
        }
        if([selectedIngredient.inShoppingBasket intValue] == 1){
            selectedIngredient.inShoppingBasket = [NSNumber numberWithInt: 0];
        } else {
            selectedIngredient.inShoppingBasket = [NSNumber numberWithInt: 1];
        }
        // persist changes
        AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
        [appDelegate saveContext];
        
        // refresh cell
        [tableView reloadData];
    }
}


@end
