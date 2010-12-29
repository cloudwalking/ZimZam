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