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
