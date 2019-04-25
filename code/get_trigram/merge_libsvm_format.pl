require "../predefine.pl";

$dir0="../../result/merged_FeatureVector";
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

open(OUT,">$dir1/FV")||die;

for($i=0;$i<@SubLoc;$i++)
{
	$infile="../../result/$SubLoc[$i]/FeatureVector/tenproperties-trigram/libsvm_format/FV";
	open(IN,$infile)||die;
	@in=<IN>;	
	close(IN);
	for($j=0;$j<@in;$j++)
	{	
		$in[$j]=~s/\n//;
		$in[$j]=~s/\r//;
	}

	for($j=0;$j<@in;$j++)
	{
		print OUT $in[$j],"\n";
	}
	print "The $i class is finished\n";
}
close(OUT);
print "The program is over!\n";