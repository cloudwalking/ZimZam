//
//  ZimZamNYTimesRSSParser.h
//  ZimZam
//
//  Created by Reed Morse on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface NYTimesRSSParser : NSObject  <NSXMLParserDelegate>{
	NSMutableArray *articlesArray;
	NSMutableString *textInProgress;
	NSString *tagInProgress;
	Article *tempArticle;
	BOOL inItem;
}

@property (retain, nonatomic) NSString *tagInProgress;
@property (retain, nonatomic) NSMutableString *textInProgress;
@property (retain, nonatomic) NSMutableArray *articlesArray;
@property (retain, nonatomic) Article *tempArticle;
@property BOOL inItem;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
