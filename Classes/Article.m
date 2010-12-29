//
//  NYTimesArticle.m
//  ZimZam
//
//  Created by Reed Morse on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Article.h"

@implementation Article

@synthesize title, urlString, body;

-(NSString *)description {
	return [NSString stringWithFormat:@"ARTICLE \n title:%@ \n urlString:%@ \n body:%@",
			title, urlString, body];
}

-(void)dealloc {
	[title release];
	[urlString release];
	[body release];
	[super dealloc];
}

@end
