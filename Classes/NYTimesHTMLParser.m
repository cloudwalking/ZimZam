//
//  ZimZamNYTimesHTMLParser.m
//  ZimZam
//
//  Created by Reed Morse on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NYTimesHTMLParser.h"


@implementation NYTimesHTMLParser
@synthesize tagInProgress, textInProgress, inArticle, articleDivs, articleText;

-(NYTimesHTMLParser *)init {
	[super init];
	
	if(self) {
		articleDivs = [NSArray arrayWithObjects:@"entry-content", @"articleBody", nil];
		inArticle = NO;
		articleText = [[NSMutableString alloc] init];
	}
	
	return self;
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict
{	
	NSLog(@"RSSParser started %@", elementName);
//	NSLog(@"dictionary: %@", attributeDict);
//	for(NSString *divName in articleDivs) {
//		if([elementName isEqualToString:divName]) {
//			
//			inArticle = YES;
//		}
//	}
//	
//	if(inArticle && [elementName isEqualToString:@"p"]) {
//		NSLog(@"RSSParser (in article) started %@", elementName);
//		tagInProgress = [elementName copy];
//		textInProgress = [[NSMutableString alloc] init];
//	}
}

- (void)parser:(NSXMLParser *)parser 
foundCharacters:(NSString *)string {
	NSLog(@"RSSParser found: %@", string);
//	if(inArticle && [tagInProgress isEqualToString:@"p"]) {
//		
//		[textInProgress appendString:string];
//	}
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName {
	NSLog(@"RSSParser finished: %@", elementName);
//	if(inArticle) {
//		if([elementName isEqualToString:@"p"]) {
//				NSLog(@"RSSParser finished: %@", elementName);
//			[articleText appendString:textInProgress];
//			[textInProgress release];
//			textInProgress = nil;
//			[tagInProgress release];
//			tagInProgress = nil;
//		} else {
//			for(NSString *divName in articleDivs) {
//				if([elementName isEqualToString:divName]) {
//					NSLog(@"RSSParser finished: %@", elementName);
//					inArticle = NO;
//				}
//			}
//		}
//	}
}

-(void)dealloc {
	[articleText release];
	[super dealloc];
}

@end
