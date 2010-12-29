//
//  ZimZamNYTimesRSSParser.m
//  ZimZam
//
//  Created by Reed Morse on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NYTimesRSSParser.h"


@implementation NYTimesRSSParser

@synthesize tempArticle, inItem, textInProgress, tagInProgress, articlesArray;

-(NYTimesRSSParser *)init {
	NSLog(@"NYTimesRSSParser init");
	[super init];
	
	if(self) {
		inItem = NO;
		
		articlesArray = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict
{	
	if([elementName isEqualToString:@"item"]) {
		NSLog(@"RSSParser started %@", elementName);
		inItem = YES;
		tempArticle = [[Article alloc] init];
	}
	
	if(inItem && 
	   ([elementName isEqualToString:@"title"] ||
		[elementName isEqualToString:@"link"])) {
		NSLog(@"RSSParser (in article) started %@", elementName);
		tagInProgress = [elementName copy];
		textInProgress = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser 
foundCharacters:(NSString *)string {
	if(inItem && 
	   ([tagInProgress isEqualToString:@"title"] ||
		[tagInProgress isEqualToString:@"link"])) {
		   NSLog(@"RSSParser found: %@", string);
		   [textInProgress appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName {
	if(inItem) {
		if([elementName isEqualToString:@"title"]) {
			NSLog(@"RSSParser finished: %@", elementName);
			tempArticle.title = textInProgress;
		} else if([elementName isEqualToString:@"link"]) {
			NSLog(@"RSSParser finished: %@", elementName);
			tempArticle.urlString = textInProgress;
		} else if([elementName isEqualToString:@"item"]) {
			NSLog(@"RSSParser finished: %@", elementName);
			[articlesArray addObject:tempArticle];
			[tempArticle release];
			tempArticle = nil;
			inItem = NO;
		}
		
		[textInProgress release];
		textInProgress = nil;
		[tagInProgress release];
		tagInProgress = nil;
	}
}

-(void)dealloc {
	[articlesArray release];
	[super dealloc];
}

@end
