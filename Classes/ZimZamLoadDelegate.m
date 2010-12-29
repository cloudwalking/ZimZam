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

#import "ZimZamLoadDelegate.h"

@implementation ZimZamLoadDelegate

@synthesize options;

- (void)webView:(UIWebView *)sender didFailLoadWithError:(NSError *)error {
	fprintf(stderr, "... something went wrong with load: %s", [[error localizedDescription] UTF8String]);
}
- (void)webView:(UIWebView *)sender didFailProvisionalLoadWithError:(NSError *)error {
	fprintf(stderr, "... something went wrong with provisional load: %s", [[error localizedDescription] UTF8String]);
}
- (void)webViewDidStartLoad:(UIWebView *)sender {
	webViewLoads++;
}
- (void)webViewDidFinishLoad:(UIWebView *)sender {
	NSTimeInterval delay = [[options objectForKey:@"delay"] doubleValue];

	if(--webViewLoads == 0) {
		NSLog(@"Webview did finish loading");
		[self performSelector:@selector(doGrab:) withObject:sender afterDelay:delay];
	}
}

-(void)resetWebview:(UIWebView *)webView {
	webView.autoresizesSubviews = YES;
	CGRect rectangle = CGRectMake(0, 0, [[options objectForKey:@"width"] floatValue], [[options objectForKey:@"height"] floatValue]);
	[webView setFrame:rectangle];
}

-(void)doGrab:(UIWebView *)webView {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"html_done" object:nil];
}

-(void) start:(UIWebView *)webView {
	NSLog(@"start");
	webViewLoads = 0;
	[self getURL:webView];
}

-(void) getURL:(UIWebView *)webView {
	NSString *url = [options objectForKey:@"url"];
	webViewLoads = 0;
	
	[self resetWebview:webView];

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[request addValue:[options objectForKey:@"value"] forHTTPHeaderField:[options objectForKey:@"header"]];
	
	[webView loadRequest:request];
}

-(NSString *)description {
	return @"Reed's ZimZamLoadDelegate";
}

-(void)dealloc {
	[super dealloc];
}

@end