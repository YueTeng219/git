#! usr/bin/perl
my @line1;
my @line2;
my @line_X;
my @line_Y;
open IN, "</users/tengyue/desktop/R1.txt" or die($!);
while (<IN>){
	chomp;
	@line_X= split "\t", $_;
	push @line1,"$line_X[0]	$line_X[1]";
	push @line2,"$line_X[9]";
}
close IN;

my %h;
my $l;
$l =scalar @line1 -1;
foreach (0..$l){
	$h{@line1[$_]}= "$line2[$_]";
}


open IN, "</users/tengyue/desktop/R2.txt" or die($!);
while (<IN>){
	@line_Y= split "\t", $_;
	if (exists $h{"$line_Y[0]	$line_Y[1]"}){
		my $a=$h{"$line_Y[0]	$line_Y[1]"};
		print "$_	$a\n";
	}
}
close IN;