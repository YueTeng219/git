#! /usr/bin/perl
my @buf;
my $TYPE;
my $REF;
my $ALT;
open IN , "</users/tengyue/desktop/buf.txt" or die($!);
while (<IN>) {
	chomp;
	if ($_=~/\+/){
		@buf=split "\t" , $_;
		if ($buf[6] eq substr ($buf[2],1,1) and $buf[7] eq substr ($buf[2],1,1)){
			$TYPE="0/0";
		}
		if ($buf[6] eq substr ($buf[2],3,1) and $buf[7] eq substr ($buf[2],3,1)){
			$TYPE="1/1";
		}
		if ($buf[6] eq substr ($buf[2],1,1) and $buf[7] eq substr ($buf[2],3,1)){
			$TYPE="0/1";
		}
		if ($buf[6] eq substr ($buf[2],3,1) and $buf[7] eq substr ($buf[2],1,1)){
			$TYPE="0/1";
		}
		$REF=substr ($buf[2],1,1);
		$ALT=substr ($buf[2],3,1);
		print "$buf[3]	$buf[4]	.	$REF	$ALT	.	.	AC=.;AF=.;AN=.;DB;DP=.;ExcessHet=.;MLEAF=.;set=Intersection	GT	$TYPE\n";
	}else{
		@buf=split "\t" , $_;
		$buf[2]=~tr/ATCG/TAGC/;
		$buf[6]=~tr/ATCG/TAGC/;
		$buf[7]=~tr/ATCG/TAGC/;
		if ($buf[6] eq substr ($buf[2],1,1) and $buf[7] eq substr ($buf[2],1,1)){
			$TYPE="0/0";
		}
		if ($buf[6] eq substr ($buf[2],3,1) and $buf[7] eq substr ($buf[2],3,1)){
			$TYPE="1/1";
		}
		if ($buf[6] eq substr ($buf[2],1,1) and $buf[7] eq substr ($buf[2],3,1)){
			$TYPE="0/1";
		}
		if ($buf[6] eq substr ($buf[2],3,1) and $buf[7] eq substr ($buf[2],1,1)){
			$TYPE="0/1";
		}
		$REF=substr ($buf[2],1,1);
		$ALT=substr ($buf[2],3,1);
		print "$buf[3]	$buf[4]	.	$REF	$ALT	.	.	AC=.;AF=.;AN=.;DB;DP=.;ExcessHet=.;MLEAF=.;set=Intersection	GT	$TYPE\n";
	}
}
