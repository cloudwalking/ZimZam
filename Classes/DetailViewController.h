//
//  DetailViewController.h
//  ZimZam
//
//  Created by Reed Morse on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    
    id detailItem;
	
    UITextView *detailDescriptionLabel;
	Article *article;
	UIWebView *webView;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) IBOutlet UITextView *detailDescriptionLabel;

@property (nonatomic, retain) Article *article;
@property (nonatomic, retain) UIWebView *webView;

@end
