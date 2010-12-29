//
//  ZimZamNYTimesHTMLParser.h
//  ZimZam
//
//  Created by Reed Morse on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NYTimesHTMLParser : NSObject <NSXMLParserDelegate> {
	NSString *tagInProgress;
	NSMutableString *textInProgress;
	NSMutableString *articleText;
	NSArray *articleDivs;
	BOOL inArticle;
}

@property (retain, nonatomic) NSArray *articleDivs;
@property (retain, nonatomic) NSString *tagInProgress;
@property (retain, nonatomic) NSMutableString *textInProgress;
@property (retain, nonatomic) NSMutableString *articleText;
@property BOOL inArticle;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
