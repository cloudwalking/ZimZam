//
//  NYTimesArticle.h
//  ZimZam
//
//  Created by Reed Morse on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Article : NSObject {
	NSString *title;
	NSString *urlString;
	NSString *body;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSString *body;

@end
