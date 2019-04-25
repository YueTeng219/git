#! /usr/bin/perl
my @buf;
my @CHROM;
my @POS;
my @REF_ALT;
my @REF;
my @ALT;
my @Allele1;
my @Allele2;
open IN , "</users/tengyue/desktop/buf.txt" or die($!);
while (<IN>) {
	chomp;
	if ($_=~/\+/){
		@buf=split "\t" , $_;
		push (@CHROM,@buf[3]);
		push (@POS,@buf[4]);
		push (@REF_ALT,@buf[2]);
		push (@Allele1,@buf[6]);
		push (@Allele2,@buf[7]);
	}else{
		@buf=split "\t" , $_;
		push (@CHROM,@buf[3]);
		push (@POS,@buf[4]);
		@buf[2]=~tr/ATCG/TAGC/;
		@buf[6]=~tr/ATCG/TAGC/;
		@buf[7]=~tr/ATCG/TAGC/;
		push (@REF_ALT,@buf[2]);
		push (@Allele1,@buf[6]);
		push (@Allele2,@buf[7]);
	}
}
foreach (@REF_ALT){
	my $a= substr ($_,1,1);
	my $b= substr ($_,3,1);
	push (@REF,$a);
	push (@ALT,$b);
}


my @TYPE;
my $length=scalar @CHROM-1;
my @L= (0..$length);
foreach (@L){
	if (@Allele1[$_] eq @REF[$_] and @Allele2[$_] eq @REF[$_]){
		push (@TYPE,"0/0");
	}
	if (@Allele1[$_] eq @ALT[$_] and @Allele2[$_] eq @ALT[$_]){
		push (@TYPE,"1/1");
	}
	if (@Allele1[$_] eq @REF[$_] and @Allele2[$_] eq @ALT[$_]){
		push (@TYPE,"0/1");
	}
	if (@Allele1[$_] eq @ALT[$_] and @Allele2[$_] eq @REF[$_]){
		push (@TYPE,"0/1");
	}
}


#print "@CHROM\n","@POS\n","@REF\n","@ALT\n","@Allele1\n","@Allele2\n";
#print "@TYPE\n";



foreach (@L){
	print "@CHROM[$_]	@POS[$_]	.	@REF[$_]	@ALT[$_]	.	.	AC=.;AF=.;AN=.;DB;DP=.;ExcessHet=.;MLEAF=.;set=Intersection	GT	@TYPE[$_]\n";
}









