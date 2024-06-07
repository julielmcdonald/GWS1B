#!/usr/bin/perl

use warnings;
use strict;

my %basemap;
my @bases=("A","C","G","T");
for (my $q=0;$q<scalar(@bases);$q++){
    $basemap{$bases[$q]}=[$q];
}

while (<STDIN>){
    chomp;
    my $totcounts=0;
    my @line=split(/\t/,$_);
    my $linesize=scalar(@line);
#    print "$line[6]\n";
    print "$line[0]\t$line[1]\t$line[2]\t";
    for (my $z=0;$z<($linesize-4)/3;$z++){
#	print "\nZcount\t$line[0]\t$line[1]\t$z\n";
	my $step=0;
	my $substlen=0;
	my %indel_list;
	for (my $q=0;$q<length($line[3*$z+4]);$q++){
	    my $occ_numb=0;
	    if ((substr($line[3*$z+4],$q,1)=~m/[\-\+]/)&(substr($line[3*$z+4],$q+1,1)=~m/\d/)){
#		print "$line[3*$z+4]\n";
		$step=$q;
		my $p=0;
		while (!(substr($line[3*$z+4],$q+$p,1)=~m/[ATGCatgc]/)){
		    $p++;
		}
		my $toremove=substr($line[3*$z+4],$step,(substr($line[3*$z+4],$step+1,$p-1)+2));
		my $substN="N";
		if (length($toremove)>1){
		    for (my $i=1;$i<length($toremove)-2;$i++){
			$substN.="N";
		    }
		}
		my $line_preremove=$line[3*$z+4];
		my $occ_numb= () = $line_preremove=~/\Q$toremove/g;
#		print "$toremove\t$occ_numb\t";
		$line[3*$z+4]=~s/\Q$toremove/$substN/g;
		$toremove = uc $toremove ;
		if (not exists $indel_list{"$toremove"}){
		    $indel_list{"$toremove"}=[0];
		}
		$indel_list{"$toremove"}[0]+=$occ_numb;
#		print "\n\n$toremove\t$substN\n";
#                print "$line[3*$z+4]\n";
		$q+=$p;
	    }
	}
	$line[3*$z+4]=~s/[Nn]//g;
	$totcounts=0;
	$line[3*$z+4]=~s/\^//g;
	$line[3*$z+4]=~s/K//g;
	$line[3*$z+4]=~s/I//g;
	$line[3*$z+4]=~s/\./$line[2]/g;
	$line[3*$z+4]=~s/\,/$line[2]/g;
        $line[3*$z+4]=~s/\\*//g;
	my $a1=length($line[3*$z+4]);
	$line[3*$z+4]=~s/a//g;
	$line[3*$z+4]=~s/A//g;
	my $acounts=$a1-length($line[3*$z+4]);
#	printf(($a-length($line[3*$z+4]))."\t");
	my $c=length($line[3*$z+4]);
	$line[3*$z+4]=~s/C//g;
	$line[3*$z+4]=~s/c//g;
	my $ccounts=$c-length($line[3*$z+4]);
# printf(($c-length($line[3*$z+4]))."\t");
	my $g=length($line[3*$z+4]);
	$line[3*$z+4]=~s/G//g;
	$line[3*$z+4]=~s/g//g;
	my $gcounts=$g-length($line[3*$z+4]);
#	printf(($g-length($line[3*$z+4]))."\t");
	my $t=length($line[3*$z+4]);
	$line[3*$z+4]=~s/T//g;
	$line[3*$z+4]=~s/t//g;
	my $tcounts=$t-length($line[3*$z+4]);
#	printf(($t-length($line[3*$z+4]))."\t");

       $totcounts=$acounts+$ccounts+$gcounts+$tcounts;
	my @counttab=($acounts,$ccounts,$gcounts,$tcounts);
#	@counttab=sort(@counttab);
	print "$totcounts\t";
	if ($totcounts>0){
	    my $afreq=sprintf("%.8f",$acounts/$totcounts);
	    my $cfreq=sprintf("%.8f",$ccounts/$totcounts); 
	    my $gfreq=sprintf("%.8f",$gcounts/$totcounts); 
	    my $tfreq=sprintf("%.8f",$tcounts/$totcounts); 
#	    my $x=sprintf("%.4f",1-$counttab[3]/$totcounts);
	    my $x=0;
	    $line[2]= uc($line[2]); 
	    if ($line[2] ne "N"){
            $x=sprintf("%.8f",1-$counttab[$basemap{$line[2]}[0]]/$totcounts);
	    }
	    else {
		my @freqarr=($afreq,$cfreq,$gfreq,$tfreq);
		@freqarr = sort @freqarr;
            $x=sprintf("%.8f",1-$freqarr[3]);
	    }		
	    print "$afreq\t$cfreq\t$gfreq\t$tfreq\t$x\t";
       	    foreach my $key (sort {$a cmp $b} keys %indel_list){
		print "$key:$indel_list{$key}[0];";
	    }
	    print "\t";
	}
	else {
	    print "0\t0\t0\t0\t0\t0\t";
	}
    }
    print "\n";
}
