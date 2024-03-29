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
my @ratings = $tree->findvalues('//p[@class="star-rating"]/attribute::class');
my @availability = $tree->findvalues('//p[@class="instock availability"]/text()');

# Print the details of the books
for my $i (0 .. $#titles) {
    my $title = $titles[$i];
    my $price = $prices[$i];
    my ($rating) = $ratings[$i] =~ /star-rating ([\w-]+)/;
    my $availability = $availability[$i];
    
    print "Title: $title\nPrice: $price\nRating: $rating\nAvailability: $availability\n\n";
}

# Clean up
$tree->delete;
