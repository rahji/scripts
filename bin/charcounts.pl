#!/usr/bin/perl

# show a frequency distribution of characters in a file that you specify

use strict;
use warnings;

my $filename = shift @ARGV;
my $char;
my $total;
my %chars;

open(FH,$filename) || die("Error: couldn't open file $filename\n");
while (read(FH,$char,1)) {
    next unless $char =~ /\S/;
    $chars{$char}++;
}
close(FH);

print "\n";

#while (my($letter,$count) = each(%chars)) {
foreach my $letter (sort { ($chars{$a} <=> $chars{$b}) } keys %chars) {
    printf("%7d\t%s\n", $chars{$letter}, $letter);
    $total += $chars{$letter};
}

printf("\n%7d\tDifferent Characters\n", scalar(keys(%chars)));
printf("%7d\tTotal Characters\n\n", $total);

