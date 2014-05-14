//
//  AboutViewController.m
//  cocktail
//
//  Created by Thomas Bachmann on 07.10.12.
//
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.

    // about label
    UILabel *label = (UILabel *)[self.view viewWithTag:1];
    label.text = NSLocalizedString(@"AboutCocktailKey",nil);
    
    // about text
    label = (UILabel *)[self.view viewWithTag:2];
    label.text = NSLocalizedString(@"AboutCocktailTextKey",nil);
    
    // credits label
    label = (UILabel *)[self.view viewWithTag:3];
    label.text = NSLocalizedString(@"CreditsKey",nil);
    
    // credits text
    label = (UILabel *)[self.view viewWithTag:4];
    label.text = NSLocalizedString(@"CreditsTextKey",nil);
    
    // find us label
    label = (UILabel *)[self.view viewWithTag:5];
    label.text = NSLocalizedString(@"FindUsOnKey",nil);
    
    // set html content
    UIWebView *webView = (UIWebView*)[self.view viewWithTag:6];
    NSString *html = @"<html><head><title>About</title></head><body><ul style=\"padding:0; margin:0; list-style: none; line-height: 1.6em;\"><li style=\"padding:0; margin:0;\"><a href=\"http://www.cocktailberater.de\">www.cocktailberater.de</a></li><li style=\"padding:0; margin:0;\"><a href=\"http://www.twitter.com/cocktailberater\">Twitter (@cocktailberater)</a></li><li style=\"padding:0; margin:0;\"><a href=\"http://www.facebook.com/cocktailberater\">Facebook</a></li></ul><br /><a href=\"http://www.facebook.com/cocktailberater\"><img src=\"facebook_like_button_big.jpg\" style=\"height: 60px\" /></a></body></html>";
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [webView loadHTMLString:html baseURL:baseURL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Web View Delegate

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
