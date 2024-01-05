use strict;
use warnings;
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;

# Create a new WWW::Mechanize object
my $mech = WWW::Mechanize->new();

# Specify the URL to scrape
my $url = 'http://books.toscrape.com/';
$mech->get($url);

# Parse the HTML content using HTML::TreeBuilder::XPath
my $tree = HTML::TreeBuilder::XPath->new_from_content($mech->content);

# Use XPath to extract information
my @titles = $tree->findvalues('//h3/a/@title');
my @prices = $tree->findvalues('//p[@class="price_color"]');

# Print the titles of the book along with their prices
for my $i (0 .. $#titles) {
    my $title = $titles[$i];
    my $price = $prices[$i];
    print "Title: $title\nPrice: $price\n\n";
}
# Clean up
$tree->delete;
