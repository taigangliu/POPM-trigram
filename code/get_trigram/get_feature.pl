require "../predefine.pl";

$ClassNo=$ARGV[0];

$dir0="../../result/$SubLoc[$ClassNo]/FeatureVector";
if(opendir(DIR0,$dir0))
{
	closedir(DIR0);
}
else
{
	mkdir ($dir0,0755)||die;
}
$dir1="$dir0/tenproperties-trigram";
if(opendir(DIR1,$dir1))
{
	closedir(DIR1);
}
else
{
	mkdir ($dir1,0755)||die;
}
$dir2="$dir1/original_vector";
if(opendir(DIR2,$dir2))
{
	closedir(DIR2);
}
else
{
	mkdir ($dir2,0755)||die;
}

sub get_trigram
{
	my ($ref1,$ref2,$ref3)=@_;
	my (@array1,@array2,@array3,$i,$sigma);
	
	@array1=@$ref1;
	@array2=@$ref2;
	@array3=@$ref3;
			
	if(@array1!=@array2 || @array1!=@array3)
	{
		print "ERROR!\n";
		die;
	}		
		
	$sigma=0;
	for($i=0;$i<=scalar(@array1-3);$i++)
	{
		$sigma=$sigma+scalar($array1[$i]*$array2[$i+1]*$array3[$i+2]);
	}	
	$sigma=scalar($sigma/(@array1-2)); 
	return $sigma;	
}

sub get_vector
{
	my ($infile)=@_;	
	my (@in,@vector,$i,$j,$k,@temp1,@temp2,@temp3);
	
	open(IN,$infile)||die;
	@in=<IN>;	
	close(IN);
	for($i=0;$i<@in;$i++)
	{	
		$in[$i]=~s/\n//;
		$in[$i]=~s/\r//;
	}
		
	if(scalar(@in)!=10)
	{
		print "ERROR!\n";
		die;
	}
	
	@vector=();
		
	for($i=0;$i<10;$i++)
	{
		@temp1=split(/ /,$in[$i]);
		for($j=0;$j<10;$j++)
		{
			@temp2=split(/ /,$in[$j]);
			for($k=0;$k<10;$k++)
			{
				@temp3=split(/ /,$in[$k]);
				$vector[$k+10*$j+100*$i]=get_trigram(\@temp1,\@temp2,\@temp3);
			}			
		}
	}

	return @vector;
}

$infile="../../dataset/$SubLoc[$ClassNo]";
open(IN,$infile)||die;
@in=<IN>;
chomp @in;
close(IN);
$SeqNum=@in/2;

$outfile=">$dir2/FV";
open(OUT,$outfile)||die;

for($i=0;$i<$SeqNum;$i++)
{
	$infile="../../result/$SubLoc[$ClassNo]/tenproperties_matrix_transposed/$i"; 
	@temp=get_vector($infile);
	for($j=0;$j<@temp;$j++)
	{
		printf OUT "%.6f ",$temp[$j];
	}
	print OUT "\n";	
	print "The $i sequence is ok!\n";
}
close(OUT);
print "The program is over!\n";