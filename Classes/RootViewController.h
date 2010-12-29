//
//  RootViewController.h
//  ZimZam
//
//  Created by Reed Morse on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYTimesRSSParser.h"

@class DetailViewController;

@interface RootViewController : UITableViewController <NSXMLParserDelegate> {
    DetailViewController *detailViewController;
	NSArray *articleList;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) NSArray *articleList;

-(NSArray *)newArticleList;
-(void)loadArticleList:(NSNotification *)n;

@end
