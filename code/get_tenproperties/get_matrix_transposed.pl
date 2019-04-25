require "../predefine.pl";

$ClassNo=$ARGV[0]; 

sub get_matrix_transposed
{
	my ($infile,$outfile)=@_;
	my (@in,$i,$j,@temp);
	
	open(IN,$infile)||die;
	@in=<IN>;
	chomp @in;
	close(IN);
	
	open(OUT,$outfile)||die;
		
	for($i=0;$i<@in;$i++) 
	{	
		$in[$i]=~s/\r//;
		$in[$i]=~s/\n//;	
		
		@temp=split(/ /,$in[$i]);		
		#print scalar(@temp),"\n";		
		@{$array[$i]}=@temp[2..$#temp];  	
		#print "@{$array[$i]}\n";		
		if(scalar($#{$array[$i]}+1)!=10) 
		{
			print "Error!\n";
			die;
		}
	}
	
	for($i=0;$i<10;$i++)     
	{
		for($j=0;$j<@in;$j++)
		{
			print OUT $array[$j][$i]," ";
			#print  $array[$j][$i]," ";
		}
		print OUT "\n";
		#print "\n\n";
	}		
	close(OUT);	
}

$dir0="../../result/$SubLoc[$ClassNo]/tenproperties_matrix_transposed";
if(opendir(DIR0,$dir0))
{
	closedir(DIR0);
}
else
{
	mkdir ($dir0,0755)||die;
}

$infile="../../dataset/$SubLoc[$ClassNo]";
open(IN,$infile)||die;
@in=<IN>;
chomp @in;
close(IN);
$SeqNum=@in/2;  

for($i=0;$i<$SeqNum;$i++)
{
	$infile="../../result/$SubLoc[$ClassNo]/tenproperties_matrix_and_sequence/$i";
	$outfile=">$dir0/$i";
	get_matrix_transposed($infile,$outfile);
	print "The $i sequence is ok!\n";
}
print "The program is over!\n";