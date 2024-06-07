#!/usr/bin/perl

use warnings;
use strict;

print "Reference\tPosition\tReference_allele\t";
while (<STDIN>){
    chomp;
    my $sampname=$_;
    print "$sampname\_coverage\t$sampname\_Afreq\t$sampname\_Cfreq\t$sampname\_Gfreq\t$sampname\_Tfreq\t$sampname\_Fraction_Non_ref\t$sampname\_Indels_Detected:counts\t";
}
print "\n";
