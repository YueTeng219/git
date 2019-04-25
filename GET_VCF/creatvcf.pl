#!/usr/bin/perl
#PN1_buffycoat;PN1_placenta;PN3_buffycoat;PN3_placenta;PN4_buffycoat;PN4_placenta;
#Chr 0-22 X Y XY ;

use strict;
use warnings;
my ($vcf,$pans,$PN1,$PN3,$PN4)=@ARGV;

open VCF,"< $vcf" or die "$!";
open PANS,"< $pans" or die "$!";
open PN1,"> $PN1" or die "$!";
open PN3,"> $PN3" or die "$!";
open PN4,"> $PN4" or die "$!";

my(@record,$key1,$key2,%hash,$ref,$var,$gt);
while (<VCF>){
	chomp;
	next if $_ =~ /^##GATKCommandLine|^##contig/;
	if ($_ =~/^##/){
		print PN1 "$_\n";
		print PN3 "$_\n";
		print PN4 "$_\n";
	}else{
		last;
	}
}
my $head="#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tbuffycoat\tplacenta\n";
print PN1 "$head";
print PN3 "$head";
print PN4 "$head";

while(<PANS>){
	chomp;
	@record=split /\t/;
	next if ($record[3] eq "XY" || $record[3] == 0 || $record[0] !~ /PN/ || $record[6] =~ /-/);
	$record[2]=~/\[([A-Z])\/([A-Z])\]/;
	$ref=$1;
	$var=$2;
#	print  "1: $1\n 2: $2\n 6: $record[6] \n 7 : $record[7]\n";
	$gt="0/0" if ($record[6] eq $record[7]  && $record[7] eq $ref);
	$gt="1/1" if ($record[6] eq $record[7]  && $record[7] eq $var);
	$gt="0/1" if ($record[6] ne $record[7]);
#       print "$gt \n";
	$key1="chr$record[3]\t$record[4]";
#	print "$key1\n";
	$key2=$record[0];
	$hash{$key1}{$key2}=$gt;
	$hash{$key1}{REF}=$ref;
	$hash{$key1}{VAR}=$var;
}

foreach(keys %hash){
	print PN1 "$_\t.\t$hash{$_}{REF}\t$hash{$_}{VAR}\t.\t.\tAC=.;AF=.;AN=.;DB;DP=.;ExcessHet=.;MLEAC=.;MLEAF=.;set=Intersection\tGT\t$hash{$_}{PN1_buffycoat}\t$hash{$_}{PN1_placenta}\n";
	print PN3 "$_\t.\t$hash{$_}{REF}\t$hash{$_}{VAR}\t.\t.\tAC=.;AF=.;AN=.;DB;DP=.;ExcessHet=.;MLEAC=.;MLEAF=.;set=Intersection\tGT\t$hash{$_}{PN3_buffycoat}\t$hash{$_}{PN3_placenta}\n";
	print PN4 "$_\t.\t$hash{$_}{REF}\t$hash{$_}{VAR}\t.\t.\tAC=.;AF=.;AN=.;DB;DP=.;ExcessHet=.;MLEAC=.;MLEAF=.;set=Intersection\tGT\t$hash{$_}{PN4_buffycoat}\t$hash{$_}{PN4_placenta}\n";
#       print "$_\n";
 
 }

close VCF;
close PANS;
close PN1;
close PN3;
close PN4;






