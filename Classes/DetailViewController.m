/*
 
 Created by Reed Morse on 12/20/10.
 Copyright 2010 Reed Morse.
 
 
 This file is part of ZimZam.
 
 ZimZam is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 ZimZam is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with ZimZam.  If not, see <http://www.gnu.org/licenses/>.
 
 */

#import "DetailViewController.h"
#import "RootViewController.h"
#import "ZimZamLoadDelegate.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)updateView;
@end



@implementation DetailViewController

@synthesize toolbar, popoverController, detailItem, detailDescriptionLabel;
@synthesize article, webView;

#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the article, update the view and dismiss the popover controller if it's showing.
 */
- (void)setArticle:(Article *)newArticle {
    if (article != newArticle) {
        [article release];
        article = [newArticle retain];
        
        // Update the view.
        [self updateView];
    }

    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
	
	// Setup default options
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								 [NSNumber numberWithInt:10], @"width",
								 [NSNumber numberWithInt:10], @"height",
								 [NSNumber numberWithBool:YES], @"javascript",
								 [NSNumber numberWithFloat:2.0], @"delay",
								 @"zimzam", @"header",
								 [NSNumber numberWithBool:NO], @"log",
								 nil];
	[dict setObject:article.urlString forKey:@"url"];

	CGRect rectangle = CGRectMake(0, 0, [[dict objectForKey:@"width"] intValue], [[dict objectForKey:@"height"] intValue]);
	webView = [[UIWebView alloc] initWithFrame:rectangle];
	
	ZimZamLoadDelegate *loadDelegate = [[ZimZamLoadDelegate alloc] init];
	loadDelegate.options = dict;
	webView.delegate = loadDelegate;
	
	[loadDelegate start:webView];
}


- (void)updateView {
	detailDescriptionLabel.text = (nil==[article body])?@"Loading":[article body];
}

// I found this online somewhere...
- (NSString *) stripTags:(NSString *)str
{
    NSMutableString *ms = [NSMutableString stringWithCapacity:[str length]];
	
    NSScanner *scanner = [NSScanner scannerWithString:str];
    [scanner setCharactersToBeSkipped:nil];
    NSString *s = nil;
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&s];
        if (s != nil)
            [ms appendString:s];
        [scanner scanUpToString:@">" intoString:NULL];
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation]+1];
        s = nil;
    }
	
    return ms;
}

-(void)doneLoadingHTML:(NSNotification *)n {
	NSLog(@"Done loading html!");
	NSLog(@"Start parsing...");
	
	NSArray *javascriptParsers = [NSArray arrayWithObjects:@"var text=\"\"; var textdivs=document.body.getElementsByClassName(\"articleBody\"); for(var i=0; i<textdivs.length; i++) { var paras=textdivs[i].getElementsByTagName(\"p\"); for(var j=0; j<paras.length; j++){text = text+\"\\n\"+paras[j].innerHTML;} } text;", 
														   @"var text=\"\"; var textdivs=document.body.getElementsByClassName(\"entry-content\"); for(var i=0; i<textdivs.length; i++) { var paras=textdivs[i].getElementsByTagName(\"p\"); for(var j=0; j<paras.length; j++){text = text+\"\\n\"+paras[j].innerHTML;} } text;", 
														   nil];
	NSString *content = nil;
	for(NSString *js in javascriptParsers) {
		NSString *result = [[webView stringByEvaluatingJavaScriptFromString:js] retain];
		if(result) {
			content = result;
			break;
		}
	}
	
//	NSLog(@"result: %@", content);
	article.body = [self stripTags:content];
	[content release];
	
	[self updateView];
}


#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc 
	 willHideViewController:(UIViewController *)aViewController 
		  withBarButtonItem:(UIBarButtonItem*)barButtonItem 
	   forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Root List";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc 
	 willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


#pragma mark -
#pragma mark View lifecycle


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(doneLoadingHTML:) 
												 name:@"html_done"
											   object:nil];
	detailDescriptionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:42.0f];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

- (void)viewDidUnload {
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

/*
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
*/

- (void)dealloc {
    [popoverController release];
    [toolbar release];

	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [detailItem release];
    [detailDescriptionLabel release];
    [super dealloc];
}

@end
