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
$dir3="$dir1/libsvm_format";
if(opendir(DIR3,$dir3))
{
	closedir(DIR3);
}
else
{
	mkdir ($dir3,0755)||die;
}

$infile="$dir2/FV";

open(IN,$infile)||die;
@in=<IN>;
close(IN);
for($i=0;$i<@in;$i++)
{	
	$in[$i]=~s/\n//;
	$in[$i]=~s/\r//;
}

$outfile=">$dir3/FV";
open(OUT,$outfile)||die;

for($i=0;$i<@in;$i++)
{
	@temp=split(/ /,$in[$i]);
	
	print OUT "$ClassNo ";
	for($j=0;$j<@temp;$j++)
	{
		print OUT scalar($j+1),":";
		printf OUT "%.6f ",$temp[$j];		
	}
	print OUT "\n";	
}
close(OUT);
print "The program is over!\n";