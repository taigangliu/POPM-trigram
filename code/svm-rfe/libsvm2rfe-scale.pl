$NameNo=0; 
@DataName=("ZW225");

$method="tenproperties-trigram";
$fvname="FV-libsvmscale";

$datadir="/data/tgliu/program/SubLoc/$DataName[$NameNo]";

$dir0="$datadir/result/svm-rfe";
if(opendir(DIR0,$dir0))
{
	closedir(DIR0);
}
else
{
	mkdir ($dir0,0755)||die;
}
$dir1="$dir0/$method";
if(opendir(DIR1,$dir1))
{
	closedir(DIR1);
}
else
{
	mkdir ($dir1,0755)||die;
}

$infile="$datadir/result/merged_FeatureVector/$method/$fvname";

open(IN,$infile)||die;
@in=<IN>;
close(IN);
for($i=0;$i<@in;$i++)
{	
	$in[$i]=~s/\n//;
	$in[$i]=~s/\r//;
}

$outfile=">$dir1/$fvname";
open(OUT,$outfile)||die;

for($i=0;$i<@in;$i++)
{
	print OUT substr($in[$i],0,1)," "; 
	
	for($j=1;$j<=1000;$j++)
	{		
		if($in[$i]=~m/ $j\:([0-9\.]*) /)
		{
			print OUT $1," ";
		}
		else
		{
			print "zero is in line: $i, feature id: $j\n";
			print OUT "0 ";
		}
	}
	print OUT "\n";
}

close(OUT);

print "The program is over!\n";